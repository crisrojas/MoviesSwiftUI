//
//  CastCaroussel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct CastCarrousel: View {
    
    let cast: [MovieCast]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Cast")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .leading(30)
            
            
            CarousselView(model: cast, spacing: 20) { actor in
                ActorAvatar(actor: actor)
                    .leading(actor == cast.first ? 30 : 0)
            }
        }
        .top(30)
        .bottom(100)
    }
}
