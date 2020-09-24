//
//  Arrray+Chunked.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 17/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation


// todo: créer une note sur cet algo, puis l'éliminer du code
extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                chunkedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return chunkedArray
    }
}

