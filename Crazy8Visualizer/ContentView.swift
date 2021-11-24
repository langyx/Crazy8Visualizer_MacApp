//
//  ContentView.swift
//  Crazy8Visualizer
//
//  Created by Yannis Lang on 13/10/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var crazyGame = CrazyGame()
    
    var body: some View {
        VStack() {
            VStack {
                Text(crazyGame.stateMsg)
                if crazyGame.currentTime != -1 {
                    Text("\(crazyGame.currentTime)")
                }
            }
            .font(.largeTitle)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(.tertiaryLabelColor)))
            .padding()
            if !crazyGame.running {
                SettingView(crazyGame: crazyGame)
                Button("Démarrer") {
                    crazyGame.start()
                }
                .padding(.top)
            }else{
                runningContent
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

extension ContentView {
    var runningContent: some View {
        ScreensView(crazyGame: crazyGame)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
