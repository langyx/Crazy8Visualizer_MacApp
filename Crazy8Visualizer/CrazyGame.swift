//
//  CrazyGame.swift
//  Crazy8Visualizer
//
//  Created by Yannis Lang on 13/10/2021.
//

import Foundation

class CrazyGame: ObservableObject {
    
    @Published var stateMsg = "Crazy8Visualizer"
    
    @Published var running = false
    @Published var nbScreens = 4
    @Published var nbProp = 4
    @Published var time: UInt32 = 60
    @Published var restTime: UInt32 = 10
    
    @Published var screens = [Screen]()
    @Published var currentTime = -1
}

extension CrazyGame {
    var endedScreen : Int {
        screens.reduce(0) { result, screen in
            result + (screen.propFilled == nbProp ? 1 : 0)
        }
    }
}

extension CrazyGame {
    func start() {
        running = true
        screens = [Screen](generating: Screen(), count: nbScreens)
        loop()
    }
    
    @discardableResult
    private func shell(_ args: String...) -> Int32 {
        let task = Process()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus
    }
    
    func say(_ text: String) {
        shell("say", text)
    }
    
    func message(_ text: String, mute: Bool = false) {
        DispatchQueue.main.async { [self] in
            self.stateMsg = text
            if !mute {
                self.say(text)
            }
        }
    }
    
    func updateState(for screen: Int, at prop: Int) {
        DispatchQueue.main.async { [self] in
            screens[screen - 1].propFilled = prop
            self.objectWillChange.send()
        }
    }
    
    func loop() {
        DispatchQueue.global(qos: .userInteractive).async {
            for screen in 1...self.nbScreens {
                
                self.message("Préparez une feuille pour dessiner \(self.nbProp) propositions pour l'écran \(screen)")
                sleep(self.restTime)
                
                for prop in 1...self.nbProp {
                    self.message("Dessiner la proposition \(prop) pour l'écran \(screen)")
                    
                    for currentTime in 0..<self.time {
                        self.message("Feuille \(screen) -> Rectangle \(prop)", mute: true)
                        DispatchQueue.main.async {
                            self.currentTime = Int(currentTime + 1)
                        }
                        sleep(1)
                    }
                    DispatchQueue.main.async {
                        self.currentTime = -1
                    }
                    
                    self.updateState(for: screen, at: prop)
                    
                    if prop != self.nbProp {
                        self.message("Préparez vous pour la proposition suivante")
                        
                    }else{
                        if screen != self.nbScreens {
                            self.message("Fin de l'écran \(screen), préparez vous pour la suite !")
                        }
                    }
                    sleep(self.restTime)
                }
            }
        }
    }
}


extension Array {
    init(generating element: @autoclosure () -> Element, count: Int) {
        self.init(unsafeUninitializedCapacity: count) {
            buffer, initializedCount in
            for i in 0..<count {
                buffer[i] = element()
                initializedCount += 1
            }
        }
    }
}
