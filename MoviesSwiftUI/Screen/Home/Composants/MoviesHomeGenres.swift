//
//  MoviesHomeGenres.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesHomeGenres: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing:16) {
            MoviesHomeSectionHeader(title: "Trending Categories", viewAllDestination: GenresView())
            HStack(spacing: 16) {
                GenreButton(genreId: 14, genre: "Fantasy", color: Color(#colorLiteral(red: 0.9999668002, green: 0.7531135678, blue: 0.0001991981844, alpha: 1)))
                GenreButton(genreId: 12, genre: "Adventure", color: Color(#colorLiteral(red: 0.9999926686, green: 0.5876129866, blue: 0.1532789767, alpha: 1)))
               }.padding(.top, 15)
            
            HStack(spacing:16) {
              GenreButton(genreId: 28, genre: "Action", color: Color(#colorLiteral(red: 0.4364725351, green: 0.735853672, blue: 0.637945354, alpha: 1)))
                GenreButton(genreId:878, genre: "Sci-Fi", color: Color(#colorLiteral(red: 0.931774199, green: 0.1786336005, blue: 0.2686362267, alpha: 1)))
                
                
            }
        }.padding(.top, 30)
    }
}

struct MoviesHomeGenres_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeGenres()
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
