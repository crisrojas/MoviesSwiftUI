//
//  MovieBackdropCard.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI


struct MovieBackdropCard: View {
    
   let movie: Movie
   @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                // We create a gray rectangle that will be shown if the image is nil
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                    .resizable()
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .cornerRadius(8)
            .shadow(radius: 4)
            Text(movie.title)
        }
        .lineLimit(1)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.backdropURL)
        }
    }
}

struct MovieBackdropCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackdropCard(movie: Movie.localMovie)
    }
}
