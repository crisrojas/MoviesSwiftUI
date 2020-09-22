//
//  MoviesRow.swift
//  MoviesSwiftUI
//
//  Created by cristian on 22/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesRow: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: 24) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .cornerRadius(4)
                    .frame(width: 66, height: 100)
                Text("Not found")
                    .font(.caption)
                KFImage(self.movie.posterURL)
                    .resizable()
                    .cornerRadius(4)
                    .frame(width: 66, height: 100)
                    
            }.shadow(color: .gray, radius: 4.0, x: 2.0, y: 2.0)
            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)

                Group {
                    Text(movie.overview.prefix(90) + "...")
                    Text(movie.ratingText)
                }.font(.caption)
                    .foregroundColor(.secondary)
                
            }
            Spacer()
        }
    }
}

struct MoviesRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviesRow(movie: Movie.localMovie)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
