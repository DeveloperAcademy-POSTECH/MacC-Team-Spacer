//
//  GradientExtension.swift
//  Spacer
//
//  Created by hurdasol on 2022/10/19.
//

import UIKit

// MARK: - make gradient

extension UIView {
    func addGradient(
        with layer: CAGradientLayer,
        gradientFrame: CGRect? = nil,
        colorSet: [UIColor],locations: [Double],
        startEndPoints: (CGPoint, CGPoint)? = nil,
        layerAt: UInt32? = nil
    ) {
        layer.frame = gradientFrame ?? self.bounds
        layer.frame.origin = .zero
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        if let index = layerAt {
            self.layer.insertSublayer(layer, at: index)
        } else {
            self.layer.insertSublayer(layer, above: self.layer)
        }
    }
}
