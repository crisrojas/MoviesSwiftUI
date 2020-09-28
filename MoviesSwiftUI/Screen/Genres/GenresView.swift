//
//  GenresListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct GenresView: View {
    @ObservedObject var genresViewModel = GenresListViewModel()
    
    init() {
        //K.setUpNavBarAppearance()
        K.setUpListAppearance()
    }
    var body: some View {
        List {
            if self.genresViewModel.model != nil {
            ForEach(0..<self.genresViewModel.model!.count) { i in
                NavigationLink(destination: MoviesListGenresView(id: self.genresViewModel.model![i].id)) {
                    Text(self.genresViewModel.model![i].name)
                        .font(.system(.headline, design: .rounded))
                        .foregroundColor(Color(K.textStrongColor!))
                }.frame(height:60)
                
            }
            } else {
                LoadingView(isLoading: true, error: nil) {
                    self.genresViewModel.loadGenres()
                }
            }
           
        }
        .onAppear() { self.genresViewModel.loadGenres() }
        .background(bgGradient())
        
    }
}

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        GenresView()
    }
}
