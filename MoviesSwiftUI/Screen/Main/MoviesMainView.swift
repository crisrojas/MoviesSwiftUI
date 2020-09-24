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
    
    @ObservedObject var nowPlayingViewModel = MoviesMainViewModel()
    
    
    init() {
       K.setUpNavBarAppearance()
       setUpListAppearance()
    }
    
    var body: some View {

        NavigationView {
            List(self.nowPlayingViewModel.model) { movie in
                
                NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    MoviesRow(movie: movie)
                        .onAppear() {
                            self.nowPlayingViewModel.loadNowPlaying(currentItem: movie.id)
                    }
                }
                
            }.background(LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.5), Color(K.themeColor!)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear() {
                if self.nowPlayingViewModel.model.isEmpty {
                    self.nowPlayingViewModel.loadNowPlaying()
                }
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
        MoviesMainView()
    }
}
