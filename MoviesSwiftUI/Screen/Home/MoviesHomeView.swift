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
    
    @ObservedObject private var popularViewModel = MoviesHomeViewModel()
    @ObservedObject private var nowPlayingViewModel = MoviesHomeViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView {
              
                VStack {
                    MoviesHomeTitle()
                    MoviesHomePopularCaroussel(movies: self.popularViewModel.movies).padding(.top, 60)
                    TrendingCategory()
                    MoviesHomeGrid(movies: self.nowPlayingViewModel.movies)
                    
                }.padding(30)
                
                }.background(bgGradient())
                .navigationBarTitle("Home")
                .navigationBarHidden(true)
        } .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            self.popularViewModel.loadPopular()
            self.nowPlayingViewModel.loadNowPlaying()
            
        }
    }
}

struct MoviesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MoviesHomeView()
                .preferredColorScheme(.dark)
            MoviesHomeView()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}

struct MoviesHomeTitle: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("🎬 moVieLabs")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color(K.textStrongColor!))
                
            }
            Spacer()
        }
    }
}

struct MoviesHomeSectionHeader<Content: View>: View {
    let title: String
    var viewAllDestination: Content
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color(K.textStrongColor!))
                .fontWeight(.black)
                .font(.system(.headline, design: .rounded))
            Spacer()
            NavigationLink(destination: viewAllDestination) {
                Text("View all")
                    .foregroundColor(Color(K.textStrongColor!))
                    .fontWeight(.bold)
                    .font(.system(.callout, design: .rounded))
                .navigationBarHidden(false)
            }
            
        }
    }
}




