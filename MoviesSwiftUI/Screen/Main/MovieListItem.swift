//
//  MovieListItem.swift
//  MoviesSwiftUI
//
//  Created by cristian on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieListItem: View {
    let movie: Movie
    var body: some View {
        HStack {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .cornerRadius(8)
                    .frame(width: 100, height: 140)
                Text("Not found")
                KFImage(self.movie.posterURL)
                    .resizable()
                    .aspectRatio(18/24, contentMode: .fill)
                    .cornerRadius(8)
                    .shadow(radius: 8)
                    .frame(width: 100, height: 140)
            }
            VStack {
                Text("\(movie.title)")
                Text("\(movie.genreText)")
                Text("\(movie.durationText)")
            }
        }
    }
}

struct MovieListItem_Previews: PreviewProvider {
    static var previews: some View {
        MovieListItem(movie: Movie.localMovie)
    }
}
