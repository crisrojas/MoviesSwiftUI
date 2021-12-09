//
//  GenresListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    @StateObject var viewModel = CategoriesViewModel()

    var body: some View {
        List {
            if self.viewModel.model != nil {
                ForEach(0..<self.viewModel.model!.count) { i in
                    NavigationLink(destination: LazyView { MoviesListView(title: self.viewModel.model![i].name, endpoint: .genre, genreId: self.viewModel.model![i].id) }) {
                        Text(self.viewModel.model![i].name)
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(Color(K.textStrongColor!))
                    }.frame(height:60)
                    
                }
            } else {
                LoadingView(isLoading: true, error: nil) {
                    self.viewModel.loadGenres()
                }
            }
            
        }.navigationBarTitle(Text("Categories"), displayMode: .inline)
        .onAppear() { self.viewModel.loadGenres() }
        .background(DefaultGradient())
        
    }
}

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}


// @todo: Delete everywhere
struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
       self.content()
    }
}
