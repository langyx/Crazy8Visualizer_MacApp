//
//  ScreensView.swift
//  Crazy8Visualizer
//
//  Created by Yannis Lang on 13/10/2021.
//

import SwiftUI

struct ScreensView: View {
    @ObservedObject var crazyGame: CrazyGame
    
    private let columns = [GridItem](repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(crazyGame.screens) { screen in
                    let screenIndex = crazyGame.screens.firstIndex(where: { $0.id == screen.id })!
                    VStack {
                        Text("Ecran \(screenIndex + 1)")
                            .font(.title)
                            .foregroundColor(.white)
                        ScreenView(nbProp: crazyGame.nbProp, screen: screen, currentScreen: screenIndex == crazyGame.endedScreen)
                            .padding()
                            .background(
                                Rectangle()
                                    .fill(Color(.tertiaryLabelColor))
                            )
                            .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct ScreensView_Previews: PreviewProvider {
    static var previews: some View {
        let crazyGame = CrazyGame()
        crazyGame.start()
        crazyGame.screens[0].propFilled = crazyGame.nbProp
        return ScreensView(crazyGame: crazyGame)
            .padding()
    }
}
