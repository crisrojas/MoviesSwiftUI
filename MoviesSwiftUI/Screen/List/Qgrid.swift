//
//  Qgrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 14/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import QGrid

struct Qgrid: View {
    var body: some View {
        QGrid(Storage.people, columns: 3) { GridCell(person: $0) }
    }
}

struct Qgrid_Previews: PreviewProvider {
    static var previews: some View {
        Qgrid()
    }
}

struct GridCell: View {
  var person: Person

  var body: some View {
    VStack() {
        Image(systemName: person.imageName)
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
        .shadow(color: .primary, radius: 5)
        .padding([.horizontal, .top], 7)
      Text(person.firstName).lineLimit(1)
      Text(person.lastName).lineLimit(1)
    }
  }
}

struct Person : Codable, Identifiable {
  var id: Int
  var firstName: String
  var lastName: String
  var imageName: String
}

struct Storage {
  static var people: [Person] = load("people.json")
  
  static func load<T: Decodable>(_ file: String) -> T {
    guard let url = Bundle.main.url(forResource: file, withExtension: nil),
          let data = try? Data(contentsOf: url),
          let typedData = try? JSONDecoder().decode(T.self, from: data) else {
      fatalError("Error while loading data from file: \(file)")
    }
    return typedData;
  }
}
