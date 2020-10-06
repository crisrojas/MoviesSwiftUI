//
//  MovieDetailHeader.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//
import SafariServices
import SwiftUI
import struct Kingfisher.KFImage

struct MovieDetailHeader: View {
    
    let movie: Movie
    @State var showingTrailer = false
    
    var body: some View {
        Group {
            VStack {
                ZStack {
                    KFImage(self.movie.posterURL)
                        .placeholder {
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
                        .resizable()
                        .cornerRadius(8)
                        .shadow(radius: 8)
                    
                    if self.movie.youtubeTrailers != nil && self.movie.youtubeTrailers!.count > 0 {
                        
                        Group {
                            Button(action: {
                                let safariVC = SFSafariViewController(url: self.movie.youtubeTrailers![0].youtubeURL!)
                                UIApplication.shared.windows.first?.rootViewController?.present(safariVC, animated: true, completion: nil)
                                
                            }) {
                                ZStack {
                                    LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .leading, endPoint: .trailing)
                                    .clipShape(Circle())
                                    .shadow(color: .orange, radius: 8)
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                }.frame(width:70, height:70)
                            }.sheet(isPresented: $showingTrailer) {
                                SafariView(url: (self.movie.youtubeTrailers![0].youtubeURL!))
                            }
                        }.offset(x: 115, y: 155)
                    }
                    
                }.frame(width:230, height: 310)
                
                Text(self.movie.title ?? "Unknown title")
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundColor(Color(K.textStrongColor!))
                    .padding(.top, 20)
                Text("\(self.movie.voteAverageRounded)")
                    .font(.system(size:38, weight: .black, design: .rounded))
                    .foregroundColor(Color(K.textSoftColor!))
                    .padding(.top, 10)
                Text(self.movie.ratingStarsOutOfFive)
                    .padding(.top, 10)
                    .foregroundColor(Color.orange)
            }.padding(.top, 110)
                .background(
                    ZStack {
                        KFImage(self.movie.backdropURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .opacity(0.7)
                            .saturation(0.0)
                        bgGradient()
                    }
            )
        }
    }
}


