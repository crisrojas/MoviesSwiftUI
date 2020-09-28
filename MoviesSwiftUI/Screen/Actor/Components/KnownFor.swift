//
//  KnownFor.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct KnownFor: View {
    let knownFor: [Movie]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Known for")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
            ForEach(self.knownFor) { movie in
                NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    HStack(spacing: 30) {
                        
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
                        
                        
                        VStack(alignment: .leading) {
                            Text(movie.title ?? "Unknown")
                                .font(.system(.headline, design: .rounded))
                                .fontWeight(.black)
                                .foregroundColor(Color(K.textStrongColor!))
                            Text(movie.overview.prefix(65) + "...")
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

//struct KnownFor_Previews: PreviewProvider {
//    static var previews: some View {
//        //KnownFor()
//    }
//}
