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

// @todo: pass id as a parameter
// @todo: instantiate viewModel as StateObject
struct MovieDetailScreen: View {
    
    @StateObject var movieDetailViewModel = MovieDetailViewModel()
    let id: Int
    var body: some View {
        
        ScrollView {
            
            MovieDetailHeader(movie: self.movieDetailViewModel.model)
            
            VStack {
                
                MovieDetailInfoStack(movie: self.movieDetailViewModel.model)
                
                HStack {
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
                    Spacer()
                }
                 
                
            }
            .padding(.leading, 30)
            .padding(.trailing, 30)
            .padding(.top, 30)
            
            if self.movieDetailViewModel.model.cast != nil && self.movieDetailViewModel.model.cast!.count > 0 {
                CastCarrousel(cast: self.movieDetailViewModel.model.cast!)
            }
        }
        
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            self.movieDetailViewModel.loadMovie(id: id)
        }
    }
}





