//
//  MovieActorPicture.swift
//  MoviesSwiftUI
//
//  Created by cristian on 15/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieActorPicture: View {
    let actor: MovieCast
    var body: some View {
        Group {
            VStack {
                if self.actor.profileURL != nil {
                    KFImage(URL(string:self.actor.profileURL!))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width:120,height: 120)
                        .clipShape(Circle())
                } else {
                    PlaceholderAvatar()
                }
                Text(actor.name)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct MovieActorPicture_Previews: PreviewProvider {
    static var previews: some View {
        MovieActorPicture(actor: Movie.localMovie.cast![0])
    }
}
