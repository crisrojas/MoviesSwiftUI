//
//  ActorAvatar.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//


import SwiftUI
import struct Kingfisher.KFImage

struct ActorAvatar: View {
    let actor: MovieCast
    var body: some View {
        
        
        NavigationLink(destination: ActorView(id: actor.creditId ?? "")) {
            if self.actor.profilePath != nil {
                KFImage(URL(string: self.actor.profileURL!))
                    .placeholder {
                        ZStack {
                            Rectangle()
                                .fill(Color(K.textSoftColor!).opacity(0.5))
                                .frame(width:60, height:60)
                                .cornerRadius(12)
                            Image(systemName: "arrow.2.circlepath.circle")
                                .font(.largeTitle)
                                .opacity(0.3)
                        }
                    }
                    // necessary to render properly an image inside a navigationlink
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:60, height:60)
                    .cornerRadius(12)
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color(K.textSoftColor!).opacity(0.5))
                        .frame(width:60, height:60)
                        .cornerRadius(12)
                    Text("No pic")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(K.textStrongColor!))
                }
            }
        }
    }
}
//
//struct ActorAvatar_Previews: PreviewProvider {
//    static var previews: some View {
//        ActorAvatar()
//    }
//}
