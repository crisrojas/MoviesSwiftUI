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
        
        VStack(spacing: 0) {
            
            posterView
            
            Text(title)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundColor(Color(K.textStrongColor!))
                .top(28)
            
            Text(averageVote)
                .font(.system(size: 38, weight: .black, design: .rounded))
                .foregroundColor(Color(K.textSoftColor!))
                .top(10)
            
            Text(ratingStars)
                .foregroundColor(Color.orange)
                .top(10)
        }
    }
    
}


// MARK: - Sub Views
private extension MovieDetailHeader {
    
    
    var posterView: some View {

        AsyncImage(url: posterURL) { image in
            image.resizable()
        } placeholder: {
            Color(K.primaryColor!)
                .overlay(ProgressView())
        }
        .cornerRadius(8)
        .shadow(radius: 8)
        .overlay(trailerButton)
        .width(230)
        .height(310)
    }
    
    @ViewBuilder
    var trailerButton: some View {
        
        if let url = trailerURL {
            Image(systemName: "play.fill")
                .foregroundColor(.white)
                .width(70)
                .height(70)
                .onTap { presentVideoInSafari(url: url) }
                .background(trailerButonBagckground)
                .offset(x: 115)
                .offset(y: 155)
        } else { EmptyView() }
    }
    
    var trailerButonBagckground: some View {
        LinearGradient(
            gradient: Gradient(
                colors: [Color.orange, Color.yellow]),
            startPoint: .leading,
            endPoint: .trailing
        )
            .clipShape(Circle())
            .shadow(color: .orange, radius: 8)
    }
}

// MARK: - View methods
private extension MovieDetailHeader {
    
    func presentVideoInSafari(url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        
        UIApplication.shared.windows
            .first?
            .rootViewController?
            .present(
                safariVC,
                animated: true,
                completion: nil
            )
    }
}
