//
//  GenresListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var categoryViewModel = CategoriesViewModel()

    var body: some View {
        List {
            if self.categoryViewModel.model != nil {
                ForEach(0..<self.categoryViewModel.model!.count) { i in
                    NavigationLink(destination: LazyView { MoviesListView(title: self.categoryViewModel.model![i].name, endpoint: .genre, genreId: self.categoryViewModel.model![i].id) }) {
                        Text(self.categoryViewModel.model![i].name)
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(Color(K.textStrongColor!))
                    }.frame(height:60)
                    
                }
            } else {
                LoadingView(isLoading: true, error: nil) {
                    self.categoryViewModel.loadGenres()
                }
            }
            
        }.navigationBarTitle(Text("Categories"), displayMode: .inline)
        .onAppear() { self.categoryViewModel.loadGenres() }
        .background(bgGradient())
        
    }
}

struct GenresListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}

struct LazyView<Content: View>: View {
    var content: () -> Content
    var body: some View {
       self.content()
    }
}
