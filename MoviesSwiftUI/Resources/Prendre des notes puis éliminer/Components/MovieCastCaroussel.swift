//
//  MovieCastCaroussel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 15/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieCastCaroussel: View {
    let movie: Movie
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(0..<self.movie.cast!.count) { i in
                    MovieActorPicture(actor: self.movie.cast![i])
                }
            }
        }
        
    }
}

struct MovieCastCaroussel_Previews: PreviewProvider {
    static var previews: some View {
        MovieCastCaroussel(movie: Movie.localMovie)
    }
}
