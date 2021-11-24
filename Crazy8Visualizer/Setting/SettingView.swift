//
//  SettingView.swift
//  Crazy8Visualizer
//
//  Created by Yannis Lang on 13/10/2021.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var crazyGame: CrazyGame
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Stepper("Nombre d'écran : \(crazyGame.nbScreens)", value: $crazyGame.nbScreens, in: 1...8, step: 1)
            Stepper("Nombre de propositions : \(crazyGame.nbProp)", value: $crazyGame.nbProp, in: 1...8, step: 1)
            Stepper("Durée dessin : \(crazyGame.time) secondes", value: $crazyGame.time, in: 5...130, step: 15)
            Stepper("Délais : \(crazyGame.restTime) secondes", value: $crazyGame.restTime, in: 5...60, step: 5)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.tertiaryLabelColor)))
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(crazyGame: CrazyGame())
            .padding()
    }
}
