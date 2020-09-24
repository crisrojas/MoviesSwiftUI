//
//  PlaceholderAvatar.swift
//  MoviesSwiftUI
//
//  Created by cristian on 15/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct PlaceholderAvatar: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray.opacity(0.5))
                .frame(width:120, height:120)
            Text("No pic found").font(.headline)
        }
    }
}

struct PlaceholderAvatar_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderAvatar()
    }
}
