//
//  TabModel.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import Foundation

// MARK: - Model
enum Tab {
    case home
    case more
    case search
    
    var image: String {
        switch self {
        case .home: return "house"
        case .more: return "ellipsis"
        case .search: return "magnifyingglass"
        }
    }
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .more: return "More"
        case .search: return "Search"
        }
    }
}
