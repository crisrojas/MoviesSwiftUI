//
//  CastCaroussel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct CastCarrousel: View {
    let cast: [MovieCast]
    var body: some View {
        VStack(alignment: .leading) {
            Text("Cast")
                .font(.system(.headline, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .padding(.leading, 30)
            ScrollView(.horizontal) {
                HStack(spacing:20) {
                    ForEach(0..<self.cast.count) { i in
                        if i == 0 {
                            ActorAvatar(actor: self.cast[i])
                                .padding(.leading, 30)
                        } else {
                            ActorAvatar(actor: self.cast[i])
                        }
                    }
                }
                
            }
        }.padding(.top, 30)
            .padding(.bottom, 100)
    }
}


//struct CastCaroussel_Previews: PreviewProvider {
//    static var previews: some View {
//        CastCaroussel()
//    }
//}
