//
//  MovieDetailDribble.swift
//  MoviesSwiftUI
//
//  Created by cristian on 22/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SafariServices
import SwiftUI
import struct Kingfisher.KFImage

struct MovieDetailDribbleView: View {
    
    @ObservedObject var movieDetailViewModel: MovieDetailViewModel

    var body: some View {
        
        ScrollView {
            
            MovieDetailHeader(movie: self.movieDetailViewModel.model)
            
            /// Body of the detail view
            VStack {
                
                MovieDetailMetaStack(movie: self.movieDetailViewModel.model)
                
                VStack(alignment: .leading) {
                    Text("Storyline")
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(K.textStrongColor!))
                    Text(self.movieDetailViewModel.model.overview)
                        .fontWeight(.bold)
                        .padding(.top,20)
                        .font(.system(.footnote, design: .rounded))
                        
                        .foregroundColor(Color(K.textSoftColor!))
                    
                }.padding(.top, 30)
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.top, 30)
            
            if self.movieDetailViewModel.model.cast != nil && self.movieDetailViewModel.model.cast!.count > 0 {
                MovieDetailCastCarrousel(cast: self.movieDetailViewModel.model.cast!)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.movieDetailViewModel.loadMovie()
        }
    }
}

struct ActorAvatar: View {
    let actor: MovieCast
    var body: some View {
        
        
        NavigationLink(destination: ActorView(actorViewModel: ActorViewModel(creditId: self.actor.creditId ?? ""))) {
            if self.actor.profilePath != nil {
                KFImage(URL(string: self.actor.profileURL!))
                    // necessary to render properly an image inside a navigationlink
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:60, height:60)
                    .cornerRadius(12)
            } else {
                ZStack {
                    Rectangle()
                        .fill(Color(K.textSoftColor!).opacity(0.5))
                        .frame(width:60, height:60)
                        .cornerRadius(12)
                    Text("No pic")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color(K.textStrongColor!))
                }
            }
        }
    }
}

struct MovieDetailDribble_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: Movie.localMovie.id))
    }
}

struct MovieDetailMeta: View {
    let title: String
    let value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(K.textSoftColor!))
                .fontWeight(.heavy)
            Text(value)
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .padding(.top, 5)
        }.font(.footnote)
    }
}


struct MovieDetailHeader: View {
    
    let movie: Movie
    @State var showingTrailer = false
    
    var body: some View {
        Group {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color(K.primaryColor!))
                        .cornerRadius(8)
                        .shadow(radius: 8)
                    Text("No poster")
                    KFImage(self.movie.posterURL)
                        .resizable()
                        .cornerRadius(8)
                        .shadow(radius: 8)
                    
                    if self.movie.youtubeTrailers != nil && self.movie.youtubeTrailers!.count > 0 {
                        
                        Group {
                            Button(action: {
                                let safariVC = SFSafariViewController(url: self.movie.youtubeTrailers![0].youtubeURL!)
                                UIApplication.shared.windows.first?.rootViewController?.present(safariVC, animated: true, completion: nil)
                                
                            }) {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                                    .clipShape(Circle())
                                    .shadow(color: .orange, radius: 8)
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                }.frame(width:70, height:70)
                            }.sheet(isPresented: $showingTrailer) {
                                SafariView(url: (self.movie.youtubeTrailers![0].youtubeURL!))
                            }
                        }.offset(x: 115, y: 155)
                    }
                    
                }.frame(width:230, height: 310)
                
                Text(self.movie.title)
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(K.textStrongColor!))
                    .padding(.top, 20)
                Text("\(self.movie.voteAverageRounded)")
                    .font(.system(size:38, weight: .black, design: .rounded))
                    .foregroundColor(Color(K.textSoftColor!))
                    .padding(.top, 10)
                Text(self.movie.ratingStarsOutOfFive)
                    .padding(.top, 10)
                    .foregroundColor(Color.orange)
            }.padding(.top, 60)
                .background(
                    ZStack {
                        KFImage(self.movie.backdropURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.7)
                            .saturation(0.0)
                        LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.6), Color(K.themeColor!)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                    }
            )
        }
    }
}

struct MovieDetailMetaStack: View {
    let movie: Movie
    var body: some View {
        HStack {
            MovieDetailMeta(title: "Length", value: self.movie.durationText)
            
            Spacer()
            
            MovieDetailMeta(title: "Year", value: self.movie.yearText)
            
            Spacer()
            
            MovieDetailMeta(title: "Language", value: self.movie.languageText.uppercased())
            
            Spacer ()
            
            MovieDetailMeta(title: "Vote count", value: "\(self.movie.voteCount)")
            
        }
    }
}

struct MovieDetailCastCarrousel: View {
    let cast: [MovieCast]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .padding(.leading, 30)
            ScrollView(.horizontal) {
                HStack(spacing:20) {
                    ForEach(0..<self.cast.count) { i in
                        if i == 0 {
                            ActorAvatar(actor: self.cast[i])
                                .padding(.leading, 30)
                        } else {
                            ActorAvatar(actor: self.cast[i])
                        }
                    }
                }
                
            }
        }.padding(.top, 30)
            .padding(.bottom, 100)
    }
}
