//
//  CastCaroussel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct CastCarousel: View {
    
    let model: [MovieCast]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Cast")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
            // @todo:
                .leading(.horizontal)
            
            
            CarouselView(model: model, spacing: 8) { actor in
                actorAvatar(
                    url: actor.profileURL,
                    id: actor.creditId
                )
                .leading(actor == model.first ? .horizontal : 0)
                .trailing(actor == model.last ? .horizontal : 0)
            }
        }
    }
    
    func actorAvatar(url: URL?, id: String?) -> some View {
        
        
        AsyncImage(url: url) { image in
            
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .width(60)
                .height(60)
                .cornerRadius(8)
            
            
        } placeholder: {
            
            imagePlaceholder
            
        }
        .onTap(navigateTo: ActorScreen(id: id ?? ""))
        
        
    }
    
    var imagePlaceholder: some View {
        
        Color(K.textSoftColor!)
            .opacity(0.5)
            .font(.largeTitle)
            .width(60)
            .height(60)
            .cornerRadius(12)
            .opacity(0.3)
            .overlayView(ProgressView.init)
        
    }
}
