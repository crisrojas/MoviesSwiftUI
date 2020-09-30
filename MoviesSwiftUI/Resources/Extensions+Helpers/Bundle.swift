//
//  Bundle.swift
//  MoviesSwiftUI
//
//  Created by cristian on 24/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
//todo: move to test target and delete from main target
extension Bundle {
    /// Allows to decode a local file
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utils.jsonDecoder
        let decodedModel = try jsonDecoder.decode(D.self, from: data)
        return decodedModel
    }
}
