//
//  GenreButton.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct CategoryButton: View {
    let genreId: Int
    let genre: String
    let color: Color
    var body: some View {
        NavigationLink(destination: LazyView { MoviesListView(title: genre, endpoint: .genre, genreId: genreId) }) {
            
            ZStack {
                Rectangle()
                    .fill(color)
                    .cornerRadius(10)
                    .shadow(color: color.opacity(0.5),radius: 10)
                Text(genre)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
            }.frame(height:55)
            
        }
    }
}

struct GenreButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButton(genreId: 28, genre: "Adventure", color: Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
