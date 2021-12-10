//
//  ActorViewHeader.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
// @todo: Delete kingfisher everywhere withing the project
import struct Kingfisher.KFImage

struct ActorViewHeader: View {
    

    let name: String
    let pictureURL: URL?
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            ZStack {
                Rectangle()
                    .foregroundColor(Color(K.primaryColor!))
                
               actorPicture
                
                
            }
            .clipShape(Circle())
            // @replace with border
            .overlay(Circle().stroke(Color.white, lineWidth: 6))
            .shadow(color: Color.black.opacity(0.05), radius: 10)
            .size(200)
            
            
            Text(name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color(K.textStrongColor!))
            
        }
    }
    
    var actorPicture: some View {
        AsyncImage(url: pictureURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
                Text("🥸")
                    .font(.system(size: 60))
        }
    }
    
}
