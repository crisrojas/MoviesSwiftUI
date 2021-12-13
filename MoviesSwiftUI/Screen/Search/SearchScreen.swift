//
//  MovieSearchView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct SearchScreen: View {
    
    @StateObject var viewModel = SearchScreenViewModel()
    
    var body: some View {
        
        VStack {
            switch viewModel.state {
                
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(let movies):
                successView(model: movies)
            case .error(let message):
                ErrorView(message: message)
            }
        }
        .background(background)
        .navigationBarTitle("Search")
        .searchable(text: $viewModel.query)
    }
    
    func successView(model: [Movie]) -> some View {
        List(model) { movie in
            MoviesRow(movie: movie)
                .onTap(navigateTo:
                        DetailScreen.init(id: movie.id)
                        .onAppear(perform: UIApplication.dismissKeyboard)
                )
        }
    }
    
    var background: some View {
        DefaultGradient()
            .fullScreen()
            .onTapDismissKeyboard()
    }
}




struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchScreen()
    }
}
