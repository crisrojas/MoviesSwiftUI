//
//  HomeTrendingCategorySection.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct HomeCategorySection: View {
    
    var columns: [GridItem] =
             Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            HomeSectionHeading(
                title: "Trending Category",
                destination: LazyView { CategoriesScreen() }
            )
            
            TwoColumnsGrid(model: Category.allCases) { category in
                CategoryButton(model: category)
            }
            .top(15)
        }
    }
}

// MARK: - Model
enum Category: String, CaseIterable, Identifiable {
    
    case fantasy = "Fantasy"
    case adventure = "Adventure"
    case action = "Action"
    case sciFi = "Sci-Fi"
    
    var id: Int {
        switch self {
        case .fantasy: return 14
        case .adventure: return 12
        case .action: return 28
        case .sciFi: return 878
        }
    }
    
    // @todo: Manage with SwiftGen
    var color: Color {
        switch self {
        case .fantasy:
            return Color(#colorLiteral(
                red: 0.9999668002,
                green: 0.7531135678,
                blue: 0.0001991981844,
                alpha: 1
            ))
          case .adventure:
            return Color(#colorLiteral(
                red: 0.9999926686,
                green: 0.5876129866,
                blue: 0.1532789767,
                alpha: 1))
         case .action:
            return Color(#colorLiteral(
                red: 0.4364725351,
                green: 0.735853672,
                blue: 0.637945354,
                alpha: 1))
        case .sciFi:
            return Color(#colorLiteral(
                red: 0.931774199,
                green: 0.1786336005,
                blue: 0.2686362267,
                alpha: 1))
        }
    }
}
