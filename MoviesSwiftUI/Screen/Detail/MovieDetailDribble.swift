//
//  MovieDetailDribble.swift
//  MoviesSwiftUI
//
//  Created by cristian on 22/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieDetailDribble: View {
    let movie: Movie = .localMovie
    var body: some View {
        
        ScrollView {
            
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .shadow(radius: 8)
                    Text("No poster")
                    KFImage(self.movie.posterURL)
                        .resizable()
                        .cornerRadius(8)
                        .shadow(radius: 8)
                }.frame(width:250, height: 350)
                
                Text(movie.title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.03156162798, green: 0.1960586607, blue: 0.2989262938, alpha: 1)))
                    .padding(.top, 20)
                Text("\(movie.voteAverage.truncate(places: 1))")
                    .font(.system(size:28, weight: .bold, design: .rounded))
                    .foregroundColor(Color(#colorLiteral(red: 0.4117172062, green: 0.514898181, blue: 0.5723626614, alpha: 1)))
                    .padding(.top, 10)
                Text(movie.ratingStarsOutOfFive)
                    .padding(.top, 10)
                    .foregroundColor(Color.orange)
            }.padding(.top, 60)
            .background(
                ZStack {
                    KFImage(self.movie.backdropURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .opacity(0.7)
                        .saturation(0.0)
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6235200752, green: 0.7144016981, blue: 0.7057518986, alpha: 1)).opacity(0.6), .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                }
            )
            
                VStack {
                    
                    HStack {
                        MovieDetailMeta()
                        
                        Spacer()
                        
                        MovieDetailMeta()
                        
                        Spacer()
                        
                        MovieDetailMeta()
                        
                        Spacer ()
                        
                        MovieDetailMeta()
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Storyline")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(#colorLiteral(red: 0.06032121927, green: 0.2236998379, blue: 0.3246186972, alpha: 1)))
                        Text(movie.overview)
                            .fontWeight(.bold)
                            .padding(.top,10)
                            .font(.system(.footnote, design: .rounded))
                            
                        .foregroundColor(Color(#colorLiteral(red: 0.4076560438, green: 0.5110146999, blue: 0.5685629845, alpha: 1)))
                        
                    }.padding(.top, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Cast")
                            .font(.system(.headline, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color(#colorLiteral(red: 0.06032121927, green: 0.2236998379, blue: 0.3246186972, alpha: 1)))
                        ScrollView(.horizontal) {
                            HStack(spacing:20) {
                                ActorAvatar()
                                ActorAvatar()
                                ActorAvatar()
                                ActorAvatar()
                                ActorAvatar()
                            }

                        }
                    }.padding(.top, 20)
                }.padding(30)
            
            
        }.edgesIgnoringSafeArea(.all)
           
    }
}

struct ActorAvatar: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(#colorLiteral(red: 0.5712916851, green: 0.6159641743, blue: 0.6120169759, alpha: 1)).opacity(0.5))
                .frame(width:60, height:60)
                .cornerRadius(12)
            Text("No pic")
                .font(.caption)
            .foregroundColor(Color(#colorLiteral(red: 0.03187024593, green: 0.1941135228, blue: 0.2980172932, alpha: 1)))
        }
        
    }
}

struct MovieDetailDribble_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailDribble()
    }
}

struct MovieDetailMeta: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Length")
                .foregroundColor(Color(#colorLiteral(red: 0.4076560438, green: 0.5110146999, blue: 0.5685629845, alpha: 1)))
                .fontWeight(.bold)
            Text("value")
                .fontWeight(.bold)
                .foregroundColor(Color(#colorLiteral(red: 0.03472364321, green: 0.2007112205, blue: 0.3032366633, alpha: 1)))
                .padding(.top, 5)
        }.font(.footnote)
    }
}


extension Double
{
    func truncate(places : Int)-> Double
    {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
