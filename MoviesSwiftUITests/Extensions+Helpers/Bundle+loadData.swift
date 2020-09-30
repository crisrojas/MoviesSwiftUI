//
//  Bundle+loadData.swift
//  MoviesSwiftUITests
//
//  Created by cristian on 01/10/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

extension Bundle {
    
    static func loadStub(filename: String) -> Data? {
        
        /// Reference to the bundle
        // let bundle = Bundle(for: type(of: self))
        guard let bundle = Bundle(identifier: "fr.v-labs.MoviesSwiftUITests") else { return nil }
        
        let url = bundle.url(forResource: filename, withExtension: "json")
        return try! Data(contentsOf: url!)
        
    }
    
    static func loadData<D: Decodable>(filename: String) throws -> D? {
       guard let bundle = Bundle(identifier: "fr.v-labs.MoviesSwiftUITests") else { return nil }
       guard let url = bundle.url(forResource: filename, withExtension: "json") else { return nil }
       let data = try Data(contentsOf: url)
       let jsonDecoder = Utils.jsonDecoder
       let decodedModel = try jsonDecoder.decode(D.self, from: data)
       return decodedModel
   }
}
