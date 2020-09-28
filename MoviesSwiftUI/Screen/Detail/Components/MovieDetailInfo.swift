//
//  MovieDetailInfo.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI


struct MovieDetailInfoStack: View {
    let movie: Movie
    var body: some View {
        HStack {
            MovieDetailInfo(title: "Length", value: self.movie.durationText)
            Spacer()
            
            MovieDetailInfo(title: "Year", value: self.movie.yearText)
            Spacer()
            
            MovieDetailInfo(title: "Language", value: self.movie.languageText.uppercased())
            Spacer ()
            
            MovieDetailInfo(title: "Vote count", value: "\(self.movie.voteCount)")
            
        }
    }
}


struct MovieDetailInfo: View {
    let title: String
    let value: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(K.textSoftColor!))
                .fontWeight(.heavy)
            Text(value)
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .padding(.top, 5)
        }.font(.footnote)
    }
}

//struct MovieDetailInfo_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailInfo()
//    }
//}
