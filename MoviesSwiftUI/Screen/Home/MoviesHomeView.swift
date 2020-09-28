//
//  MoviesHomeView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 24/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesHomeView: View {
    
    let movies: [[Movie]] = Movie.localMovies.chunked(into: 2)
    @ObservedObject private var popularViewModel = MoviesMoreViewModel()
    @ObservedObject private var nowPlayingViewModel = MoviesMainViewModel(endpoint: "nowPlaying")
    
    var body: some View {

        NavigationView {
            ScrollView {
                VStack {
                    MoviesHomeTitle()
                    MoviesHomePopularCaroussel(movies: self.popularViewModel.model).padding(.top, 30)
                    MoviesHomeCategories()
                    MoviesHomeGrid(movies: self.nowPlayingViewModel.model)
                }.padding(30)
                    
                .navigationBarTitle("")
                
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!), Color(K.themeColor!)]),
                               startPoint: .top,
                               endPoint: .bottom).edgesIgnoringSafeArea(.all)
            )
        }
        .onAppear() {
            self.popularViewModel.loadPopular()
            self.nowPlayingViewModel.loadNowPlaying()
            
        }
    }
}

struct MoviesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeView()
            .previewDevice("iPhone 11")
    }
}



struct MoviesHomeTitle: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Discover 🎬")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color(K.textStrongColor!))
                
            }
            Spacer()
        }
    }
}

struct MoviesHomePopularCaroussel: View {
    let movies : [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            MoviesHomeSectionHeader(title: "Popular movies", endpoint: "popular")
            ScrollView(.horizontal) {
                HStack(spacing: 15) {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                            ZStack {
                                Rectangle()
                                    .fill(Color(K.primaryColor!))
                                    .cornerRadius(20)
                                Text("Not found")
                                KFImage(movie.backdropURL)
                                    .renderingMode(.original)
                                    .resizable()
                                    .frame(width:350, height:200)
                                    .aspectRatio(contentMode: .fill)
                                
                                
                                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0.0)]), startPoint: .bottom, endPoint: .top)
                                    .frame(height:150)
                                    
                                    .offset(y:50)
                                 
                                VStack(alignment: .leading) {
                                    Text(movie.title)
                                        .font(.system(.headline, design: .rounded))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.white)
                                    Text("Action, Adventure, Comedy")
                                        .font(.system(.caption, design: .rounded))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color.white)
                                        .opacity(0.6)
                                }.offset(x: -40, y: 50)
                            }.cornerRadius(20).frame(width: 350)
                            
                            
                        }.padding(.leading, movie.id == self.movies.first!.id ? 30 : 0)
                    }
                    
                }
                
            }.padding(.top, 15)
            .padding(.leading, -30)
            .padding(.trailing, -30)
        }
    }
}

struct MoviesHomeCategories: View {
    var body: some View {
        VStack(alignment: .leading, spacing:16) {
            MoviesHomeSectionHeader(title: "Trending Category", endpoint: "popular")
                
            HStack(spacing: 16) {
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.7502940297, blue: 0, alpha: 1)))
                        .cornerRadius(10)
                        .shadow(color: Color.yellow.opacity(0.5),radius: 10)
                    Text("Fantasy")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }.frame(height:60)
                
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.586561203, blue: 0.1537233591, alpha: 1)))
                        .cornerRadius(10)
                        .shadow(color: Color.orange.opacity(0.5),radius: 10)
                    Text("Adventure")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }.frame(height:60)
                
                
            }.padding(.top, 15)
            
            HStack(spacing:16) {
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.4359787405, green: 0.7338603139, blue: 0.6382646561, alpha: 1)))
                        .cornerRadius(10)
                        .shadow(color: Color.green.opacity(0.5),radius: 10)
                    Text("Action")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }.frame(height:60)
                
                ZStack {
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.9298143387, green: 0.1796685755, blue: 0.2697538137, alpha: 1)))
                        .cornerRadius(10)
                        .shadow(color: Color.red.opacity(0.5),radius: 10)
                    Text("Science fiction")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                }.frame(height:60)
                
                
            }
            
            
        }.padding(.top, 30)
    }
}

struct MoviesHomeSectionHeader: View {
    let title: String
    let endpoint: String
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(K.textStrongColor!))
                .fontWeight(.black)
                .font(.system(.headline, design: .rounded))
            Spacer()
            NavigationLink(destination: MoviesMainView(moviesViewModel: MoviesMainViewModel(endpoint: endpoint))) {
                Text("View all")
                 .foregroundColor(Color(K.textStrongColor!))
                    .fontWeight(.bold)
                .font(.system(.callout, design: .rounded))
            }
            
        }
    }
}

struct MoviesHomeGrid: View {
    let movies: [Movie]
    var body: some View {
        VStack {
            MoviesHomeSectionHeader(title: "Now playing", endpoint: "nowPlaying")
            
            UIGrid(columns: 2, list: movies) { (movie) in
                ZStack {
                    
                    NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                        KFImage(movie.posterURL)
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(210/297, contentMode: .fill)
                            .frame(width: 170)
                            .cornerRadius(10)
                    }
                    
                }
            }.padding(.top, 15)
            
        }.padding(.top, 30)
    }
}
