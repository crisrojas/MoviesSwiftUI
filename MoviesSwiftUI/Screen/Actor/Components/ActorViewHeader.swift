//
//  ActorViewHeader.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ActorViewHeader: View {
    let cast: CreditsResponse
    var body: some View {
        ZStack {
           
            KFImage(self.cast.person!.profileURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .saturation(0.5)
                .opacity(0.5)
            
            bgGradient()
            
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
                    KFImage(self.cast.person!.profileURL)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                }.clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 6))
                    .shadow(color: Color.black.opacity(0.05), radius: 10)
                    .frame(width:250, height: 250)
                
                
                Text(self.cast.person!.name!)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.black)
                    .foregroundColor(Color(K.textStrongColor!))
                
                
                
                
            }.padding(.top, 60)
            
        }.frame(height:350)
    }
}

//struct ActorViewHeader_Previews: PreviewProvider {
//    static var previews: some View {
//        ActorViewHeader()
//    }
//}
