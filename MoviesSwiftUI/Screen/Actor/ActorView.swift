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
    
    @StateObject var viewModel = ActorViewModel()
    let id: String
    
    var body: some View {
        
        ScrollView {
            if self.viewModel.model != nil {
                if self.viewModel.model!.person != nil {
                    ActorViewHeader(cast: self.viewModel.model!)
                }
                
                if self.viewModel.model!.person!.knownFor != nil {
                    KnownFor(knownFor: self.viewModel.model!.person!.knownFor!).padding(.top, 20)
                }
            }
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.viewModel.loadCredits(id: id)
        }
        
        
    }
}

struct ActorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActorView(id: "5b060680c3a3684ca0003ca0")
                .preferredColorScheme(.dark)
            ActorView(id: "5b060680c3a3684ca0003ca0")
                .preferredColorScheme(.light)
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}



