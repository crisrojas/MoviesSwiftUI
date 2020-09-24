//
//  MoviesHomeView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 24/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesHomeView: View {
    var body: some View {
        
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text("Discover 🎬")
                        .font(.system(.title, design: .rounded))
                        .fontWeight(.bold)
                    Text("Popular Movies")
                }
                Spacer()
            }
            
            Text("Popular movies")
            ScrollView(.horizontal) {
                ZStack {
                    Rectangle()
                    .fill(Color.gray)
                    .frame(width:350, height:200)
                        .cornerRadius(20)
                    VStack(alignment: .leading) {
                        Text("Jumanji: The Next Level")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("Action, Adventure, Comedy")
                    }.offset(x: -40, y: 50)
                }
            }
        }.padding()
        
    }
}

struct MoviesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeView()
            .previewDevice("iPhone 11")
    }
}
