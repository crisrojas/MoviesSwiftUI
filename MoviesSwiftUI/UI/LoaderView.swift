//
//  LoaderView.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 07/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI

struct LoaderView: View {
    
    var body: some View {
        VStack(spacing: 24) {
            ProgressView()
            Text("Loading")
                .font(.system(.title, design: .rounded))
                .fontWeight(.black)
                .foregroundColor(Color(K.textStrongColor!))
        }
    }
}
