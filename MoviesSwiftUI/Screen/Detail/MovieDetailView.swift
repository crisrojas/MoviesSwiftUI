//
//  MovieDetailView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieDetailView: View {
    
    @ObservedObject var movieDetailViewModel: MovieDetailViewModel
    //var movieDetailViewModel: MovieDetailViewModelInput
    
    var body: some View {
        ZStack {
            
            if movieDetailViewModel.movie != nil {
                MovieDetailViewList(movie: self.movieDetailViewModel.movie!)
            } else {
                LoadingView(isLoading: self.movieDetailViewModel.isLoading, error: self.movieDetailViewModel.error) {
                    self.movieDetailViewModel.loadMovie()
                }
            }
        }
        .navigationBarTitle(movieDetailViewModel.movie?.title ?? "")
        .onAppear() {
            self.movieDetailViewModel.loadMovie()
        }
    }
}

struct MovieDetailViewList: View {
    let movie: Movie
    @State private var selectedTrailer: MovieVideo?
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backdropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            HStack {
                Text(movie.genreText)
                Text("-")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            
            Text(movie.overview)
            HStack {
                if !movie.ratingText.isEmpty {
                    Text(movie.ratingText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            
            Divider()
            
            HStack(alignment: .top, spacing: 4) {
                
                if movie.cast != nil && movie.cast!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Starring").font(.headline)
                        ForEach(self.movie.cast!.prefix(9)) { cast in
                            Text(cast.name)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                
                if movie.crew != nil && movie.crew!.count > 0 {
                    VStack(alignment: .leading, spacing: 4) {
                        if movie.directors != nil && movie.directors!.count > 0 {
                            Text("Director(s)").font(.headline)
                            ForEach(self.movie.directors!.prefix(2)) { crew in
                                Text(crew.name)
                                
                            }
                        }
                        
                        if movie.producers != nil && movie.producers!.count > 0 {
                            Text("Producer(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.producers!.prefix(2)) { crew in
                                Text(crew.name)
                                
                            }
                        }
                        
                        if movie.screenWriters != nil && movie.screenWriters!.count > 0 {
                            Text("Screenwriter(s)").font(.headline)
                                .padding(.top)
                            ForEach(self.movie.screenWriters!.prefix(2)) { crew in
                                Text(crew.name)
                                
                            }
                        }
                    }
                    .frame(minWidth:0, maxWidth: .infinity, alignment: .leading)
                }
                
            }
            Divider()
            
            if movie.cast != nil && movie.cast!.count > 0 {
                MovieCastCaroussel(movie: movie)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            
            if movie.youtubeTrailers != nil && movie.youtubeTrailers!.count > 0 {
                Text("Trailers").font(.headline)
                ForEach(movie.youtubeTrailers!) { trailer in
                    Button(action: {
                        self.selectedTrailer = trailer
                    }) {
                        HStack {
                            Text(trailer.name)
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(Color(UIColor.systemBlue))
                        }
                    }
                }
            }
        }
        .sheet(item: self.$selectedTrailer) { trailer in
            SafariView(url: trailer.youtubeURL!)
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    
    let imageURL: URL
    
    //todo: imageURL should be optional?
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            KFImage(self.imageURL)
        }
        .aspectRatio(16/9, contentMode: .fit)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId:Movie.localMovie.id))
        }
    }
}
