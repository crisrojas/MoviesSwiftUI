//
//  ActorViewHeader.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

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
            .overlay(strokeView)
            .shadow(color: .black.opacity(0.05), radius: 10)
            .size(200)
            
            
            Text(name)
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color(K.textStrongColor!))
        }
    }
    
    var strokeView: some View {
        Circle().stroke(.white, lineWidth: 2)
    }
    
    var actorPicture: some View {
        /// @todo: Implement an error view for each AsyncImage in project
        AsyncImage(url: pictureURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
        } placeholder: {
                ProgressView()
        }
    }
    
}
