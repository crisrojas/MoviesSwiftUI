//
//  LoadingAnimation.swift
//  MoviesSwiftUI
//
//  Created by cristian on 06/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct LoadingAnimation: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        Circle()
                   .fill(Color.blue)
                   .frame(width: 30, height: 30)
                   .overlay(
                       ZStack {
                           Circle()
                               .stroke(Color.blue, lineWidth: 100)
                               .scaleEffect(shouldAnimate ? 1 : 0)
                           Circle()
                               .stroke(Color.blue, lineWidth: 100)
                               .scaleEffect(shouldAnimate ? 1.5 : 0)
                           Circle()
                               .stroke(Color.blue, lineWidth: 100)
                               .scaleEffect(shouldAnimate ? 2 : 0)
                       }
                       .opacity(shouldAnimate ? 0.0 : 0.2)
                       .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false))
               )
               .onAppear {
                   self.shouldAnimate = true
               }
    }
}

struct LoadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAnimation()
    }
}
