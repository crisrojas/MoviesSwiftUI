//
//  MoviesHomePopularCaroussel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesHomePopularCaroussel: View {
    let movies : [Movie]
    var body: some View {
        VStack(alignment: .leading) {
            MoviesHomeSectionHeader(title: "Popular Movies", viewAllDestination: LazyView { MoviesListView(title: "Popular", endpoint: .popular) })
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                            ZStack {
                              
                                KFImage(movie.backdropURL)
                                    .placeholder {
                                        Rectangle()
                                            .fill(Color(K.primaryColor!))
                                            .cornerRadius(20)
                                        Text("Not found")
                                        Image(systemName: "arrow.2.circlepath.circle")
                                            .font(.largeTitle)
                                            .opacity(0.3)
                                    }
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width:350, height:200)
                                    .aspectRatio(contentMode: .fill)
                                
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0.0)]), startPoint: .bottom, endPoint: .top)
                                    .frame(height:150)
                                    
                                    .offset(y:50)
                                
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(movie.title ?? "Unknown title")
                                            .font(.system(.title, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                        if movie.genres != nil {
                                            Text("Action, Adventure, Comedy")
                                            .font(.system(.caption, design: .rounded))
                                            .fontWeight(.heavy)
                                            .foregroundColor(Color.white)
                                                .multilineTextAlignment(.leading)
                                                .opacity(0.6)
                                        }
                                    }.padding(.leading, 30).offset(y:40)
                                    Spacer()
                                }
                            }.cornerRadius(20).frame(width: 350, height:200)
                            
                        }.padding(.leading, movie.id == self.movies.first!.id ? 30 : 0)
                    }
                }
                
            }.padding(.top, 15)
                .padding(.leading, -30)
                .padding(.trailing, -30)
        }
    }
}

struct MoviesHomePopularCaroussel_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomePopularCaroussel(movies: Movie.localMovies)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
