//
//  GenresListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct CategoriesScreen: View {
    
    @StateObject var viewModel = CategoriesScreenViewModel()
    
    var body: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            
            LoaderView()
                .onAppear(perform: viewModel.loadGenres)
            
        case .success(let genres):
            
            successView(model: genres)
            
        case .error(let message):
            
            ErrorView(message: message)
        }
    }
}

// MARK: - Successs View
extension CategoriesScreen {
    
    func successView(model: [Genre]) -> some View {
        
        List {
            
            ForEach(model) { genre in
                
                let destination = MoviesListView(
                    title: genre.name,
                    endpoint: .genre,
                    genreId: genre.id
                )
                
                Text(genre.name)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(Color(K.textStrongColor!))
                    .height(60)
                    .onTap(navigateTo: destination)
            }
        }
        .top(24)
        /// @todo: Large Title not collapsing on scroll
        /// .background(DefaultGradient())
        /// https://www.reddit.com/r/SwiftUI/comments/hx20uw/navigationbar_wont_collapse_swiftui/
        .navigationBarTitle("Categories")
    }
}

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
    }
}


// @todo: Delete everywhere
struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
        self.content()
    }
}
