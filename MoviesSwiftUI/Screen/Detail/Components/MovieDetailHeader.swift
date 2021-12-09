//
//  MovieDetailHeader.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//
import SafariServices
import SwiftUI
import SwiftUItilities

struct MovieDetailHeader: View {

    let title: String
    let averageVote: String
    let ratingStars: String
    let posterURL: URL?
    let trailerURL: URL?
    
    var body: some View {
        
        VStack {
        
            posterView
            
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundColor(Color(K.textStrongColor!))
                .top(20)
            
            Text(averageVote)
                .font(.system(size: 38, weight: .black, design: .rounded))
                .foregroundColor(Color(K.textSoftColor!))
                .top(10)
            
            Text(ratingStars)
                .foregroundColor(Color.orange)
                .top(10)
        }
        .top(110)
    }
    
    
    func trailerButton(url: URL) -> some View {
        
        Button {
            let safariVC = SFSafariViewController(url: url)
            UIApplication.shared.windows.first?.rootViewController?.present(safariVC, animated: true, completion: nil)
            
        } label: {
               
                Image(systemName: "play.fill")
                    .foregroundColor(.white)
                    .width(70)
                    .height(70)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                            .clipShape(Circle())
                            .shadow(color: .orange, radius: 8)
                    )
            
        }
        .offset(x: 115)
        .offset(y: 155)
    }
    
    var posterView: some View {
        
        ZStack {
            
            AsyncImage(url: posterURL) { image in
                image
                    .resizable()
                    .cornerRadius(8)
                    .shadow(radius: 8)
                
            } placeholder: {
                imagePlaeholder
            }

            if let youtubeURL = trailerURL {
                trailerButton(url: youtubeURL)
            }
        }
        .width(230)
        .height(310)
    }
    
    
    var imagePlaeholder: some View {
        
        
        
        ZStack {
            
            Rectangle()
                .fill(Color(K.primaryColor!))
                .cornerRadius(8)
                .shadow(radius: 8)
            Image(systemName: "arrow.2.circlepath.circle")
                .font(.largeTitle)
                .opacity(0.3)
        }
    }
    
}
