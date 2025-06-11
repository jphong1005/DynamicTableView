//
//  UIColor+.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/11/25.
//

import Foundation
import UIKit

extension UIColor {
    class var randomColour: UIColor {
        get {
            let rojo = CGFloat.random(in: 0...1)
            let verde = CGFloat.random(in: 0...1)
            let azul = CGFloat.random(in: 0...1)
            
            return UIColor(red: rojo, green: verde, blue: azul, alpha: 1)
        }
    }
    
    static func makeRandomColourImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100.0, height: 100.0))
        return renderer.image { context in
            UIColor.randomColour.setFill()
            
            let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: CGSize(width: 100.0, height: 100.0)),
                                    cornerRadius: 20)
            path.addClip()
            
            context.fill(path.bounds)
        }
    }
    
    static func makeBlackColourImage() -> UIImage {
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100.0, height: 100.0))
        return renderer.image { context in
            UIColor.black.setFill()
            context.fill(CGRect(origin: .zero, size: CGSize(width: 100.0, height: 100.0)))
        }
    }
}
