//
//  ScreenView.swift
//  Crazy8Visualizer
//
//  Created by Yannis Lang on 13/10/2021.
//

import SwiftUI

struct ScreenView: View {
    let nbProp: Int
    var screen: Screen
    var currentScreen: Bool
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    @State private var currentColor: Color = .red
    
    var body: some View {
        LazyVGrid(columns: [GridItem](repeating: GridItem(.flexible()), count: nbProp / 2), spacing: 20) {
            ForEach(0..<nbProp) { index in
                Rectangle()
                    .fill(color(index: index))
                    .frame(minWidth: 10, maxWidth: .infinity, minHeight: 30, idealHeight: 100, maxHeight: .infinity)
                    .padding(.horizontal, 10)
                    .overlay(
                        Group {
                            if index < screen.propFilled {
                                Image(systemName: "checkmark")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                            }
                        }
                    )
            }
        }
        .onReceive(timer) { _ in
            if currentScreen && screen.propFilled < nbProp {
                if currentColor == .red {
                    currentColor = .white
                }else{
                    currentColor = .red
                }
            }else{
                self.timer.upstream.connect().cancel()
            }
        }
    }
    
    private func color(index: Int) -> Color {
        var color: Color
        if index > screen.propFilled {
            color = .white
        }else if index < screen.propFilled {
            color = .green
        }else{
            if !currentScreen {
                color = .white
            }else{
                color = currentColor
            }
        }
        return color
    }
}

struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView(nbProp: 8, screen: Screen(propFilled: 3), currentScreen: true)
    }
}
