//
//  UIImage+shadow.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import UIKit


extension UIImage {
    static var tabBarShadow:  UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 10)

        let color1 = K.primaryColor!.cgColor.copy(alpha: 0.4)!
        let color2: CGColor = UIColor.white.cgColor.copy(alpha: 0)!
        gradientLayer.colors = [color2, color1]

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static var clear: UIImage { return UIImage() }
}
