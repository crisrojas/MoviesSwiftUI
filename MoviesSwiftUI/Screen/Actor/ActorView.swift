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
                    ActorViewHeader(cast: self.actorViewModel.model!)
                }
                
                if self.actorViewModel.model!.person!.knownFor != nil {
                    KnownFor(knownFor: self.actorViewModel.model!.person!.knownFor!).padding(.top, 20)
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



