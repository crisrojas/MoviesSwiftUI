//
//  MoviePosterCard.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviePosterCard: View {
    
    let movie: Movie
    
    var body: some View {
        ZStack {
            //todo: add gray rectangle
            KFImage(self.movie.posterURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
                .shadow(radius: 4)
        }
        .aspectRatio(3/4, contentMode: .fit)
    }
}

struct MoviePosterCard_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCard(movie: Movie.localMovie)
    }
}
