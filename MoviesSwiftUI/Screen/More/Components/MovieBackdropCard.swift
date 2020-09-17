//
//  MovieBackdropCard.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage


struct MovieBackdropCard: View {
    
   let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    KFImage(self.movie.backdropURL)
                    .resizable()
                    
                
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            Text(movie.title)
        }
        .lineLimit(1)
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.localMovie)
    }
}
