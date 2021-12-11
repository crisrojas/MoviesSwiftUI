//
//  Double+truncate.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation

extension Double {
    func reduceScale(to places: Int) -> Double {
        let multiplier = pow(10, Double(places))
        let newDecimal = multiplier * self // move the decimal right
        let truncated = Double(Int(newDecimal)) // drop the fraction
        let originalDecimal = truncated / multiplier // move the decimal back
        return originalDecimal
    }
}
