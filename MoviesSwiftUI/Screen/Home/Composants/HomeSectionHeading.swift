//
//  HomeSectionHeading.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI

struct HomeSectionHeading<Destination: View>: View {
    
    let title: String
    let destination: Destination
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .foregroundColor(Color(K.textStrongColor!))
                .fontWeight(.black)
                .font(.system(.headline, design: .rounded))
            
            Spacer()
            
            
            Text("View all")
                .foregroundColor(Color(K.textStrongColor!))
                .fontWeight(.bold)
                .font(.system(.callout, design: .rounded))
                .onTap(navigateTo: destination)
        }
    }
}
