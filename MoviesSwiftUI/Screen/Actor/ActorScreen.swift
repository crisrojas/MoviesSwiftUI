//
//  ActorView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities
import struct Kingfisher.KFImage

struct ActorScreen: View {
    
    @StateObject private var viewModel = ActorViewModel()
    let id: String
    
    var body: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            
            LoaderView()
                .onAppear { viewModel.loadCredits(id: id) }
                .background(DefaultGradient().fullScreen())
            
        case .success(let model):
            
            successView(model: model)
            
        case .error(let error):
            
            ErrorView(message: error)
            
        }
    }
}

// MARK: - Sub views
private extension ActorScreen {
    
    func successView(model: Person) -> some View {
        
        VStack {
            
            ActorViewHeader(
                name: model.name ?? "Unknown actor",
                pictureURL: model.profileURL
            )

            if let knownFor = model.knownFor  {
                KnownForView(model: knownFor)
                    .top(40)
                    .alignX(.leading)
                    .horizontal(.horizontal)
            }
        }
        .bottom(.bottom)
        .scrollify()
        .background(ImageBackground(url: model.profileURL))
    }
}


