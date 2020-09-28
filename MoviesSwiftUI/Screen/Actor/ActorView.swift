//
//  ActorView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ActorView: View {
    
    @ObservedObject var actorViewModel: ActorViewModel
    
    var body: some View {
        
        ScrollView {
            if self.actorViewModel.model != nil {
                if self.actorViewModel.model!.person != nil {
                    
                    ZStack {
                        //Rectangle()
                        KFImage(self.actorViewModel.model!.person!.profileURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .saturation(0.5)
                            .opacity(0.5)
                        
                        LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.5), Color(K.themeColor!).opacity(1)]),startPoint: .top, endPoint: .bottom)
                        
                        VStack {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(K.primaryColor!))
                                VStack {
                                    Text("😓")
                                        .font(.system(size: 60))
                                    Text("Image Not Found")
                                        .foregroundColor(Color(K.textStrongColor!))
                                        .fontWeight(.heavy)
                                }
                                KFImage(self.actorViewModel.model!.person!.profileURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                            }.clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 6))
                                .shadow(color: Color.black.opacity(0.05), radius: 10)
                                .frame(width:250, height: 250)
                            
                            
                            Text(self.actorViewModel.model!.person!.name!)
                                .font(.system(.title, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(Color(K.textStrongColor!))
                            
                            
                            
                            
                        }.padding(.top, 60)
                        
                    }.frame(height:350)
                    
                    
                    
                    
                }
                
                //Popularity bar. Not useful for the user
                //                    if self.actorViewModel.model!.person!.popularity != nil {
                //                        VStack {
                //                            ActorPopularityBar(value: self.actorViewModel.model!.person!.popularity!/10).frame(height:20)
                //
                //                        }.padding()
                //                    }
                
                if self.actorViewModel.model!.person!.knownFor != nil {
                    
                    
                    VStack(alignment: .leading) {
                        Text("Known for")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.heavy)
                            .foregroundColor(Color(K.textStrongColor!))
                        ForEach(self.actorViewModel.model!.person!.knownFor!) { movie in
                            NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id!))) {
                                HStack(spacing: 30) {
                                    // Movie Poster image
                                    ZStack {
                                        Rectangle()
                                            .fill(Color(K.primaryColor!))
                                        
                                        Text("Pic not found")
                                            .font(.system(.caption))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(K.textStrongColor!))
                                        KFImage(movie.posterURL)
                                            .renderingMode(.original)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    }.frame(width:60   , height:60).cornerRadius(8)
                                    
                                    // Movie title + overview
                                    VStack(alignment: .leading) {
                                        Text(movie.title ?? "Unknown")
                                            .font(.system(.headline, design: .rounded))
                                            .fontWeight(.black)
                                            .foregroundColor(Color(K.textStrongColor!))
                                        Text(movie.overview?.prefix(65) ?? "Overview not available")
                                            .font(.system(.caption, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(K.textSoftColor!))
                                            .padding(.top, 10)
                                    }
                                }.padding(.top, 20)
                            }
                            
                            
                        }
                    }.padding(30)
                    
                    
                }
            }
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.actorViewModel.loadCredits()
        }
        
        
    }
}

struct ActorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActorView(actorViewModel: ActorViewModel(creditId: "5b060680c3a3684ca0003ca0"))
                .preferredColorScheme(.dark)
            ActorView(actorViewModel: ActorViewModel(creditId: "5b060680c3a3684ca0003ca0"))
                .preferredColorScheme(.light)
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}

struct ActorPopularityBar: View {
    
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    
                    .foregroundColor(Color(K.textSoftColor!).opacity(0.5))
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(K.textStrongColor!))
            }
        }
        .cornerRadius(30)
    }
}
