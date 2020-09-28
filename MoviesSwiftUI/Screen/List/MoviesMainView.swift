//
//  NowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import struct Kingfisher.KFImage
import SwiftUI

struct MoviesMainView: View {
    
    @ObservedObject var moviesViewModel: MoviesMainViewModel
    
    
    init(moviesViewModel: MoviesMainViewModel) {
        self.moviesViewModel = moviesViewModel
       K.setUpNavBarAppearance()
       setUpListAppearance()
    }
    
    var body: some View {

        
            List(self.moviesViewModel.model) { movie in
                
                NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    MoviesRow(movie: movie)
                       
                        .onAppear() {
                            self.moviesViewModel.loadNowPlaying(currentItem: movie.id)
                    }
                }
                
            }.background(LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.5), Color(K.themeColor!)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
         
            .onAppear() {
                if self.moviesViewModel.model.isEmpty {
                    self.moviesViewModel.loadMovies()
                }
            }
        
    }
    
    
    func setUpListAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
}


struct NowPlayingGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoviesMainView(moviesViewModel: MoviesMainViewModel(endpoint: "nowPlaying"))
    }
}
