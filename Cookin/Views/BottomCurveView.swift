//
//  BottomCurveView.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/18/20.
//

import UIKit

class BottomCurveView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Card view frame dimensions
        let viewSize = self.bounds.size
        // Get a path to define and traverse
        let path = UIBezierPath()
        
        // Start from origin
        // Create first curve which should take up the left 1/2 of the curve view
        let bottomLeft = CGPoint(x: 0, y: viewSize.height)
        path.move(to: bottomLeft)
        let point = CGPoint(x: 0, y: 1/16 * viewSize.height)
        path.addLine(to: point)
        let endPoint1 = CGPoint(x: 5/16 * viewSize.width, y: 3/8 * viewSize.height)
        let controlPoint11 = CGPoint(x: 1/8 * viewSize.width, y: 0)
        let controlPoint12 = CGPoint(x: 1/32 * viewSize.width, y: 3/4 * viewSize.height)
        path.addCurve(to: endPoint1, controlPoint1: controlPoint11, controlPoint2: controlPoint12)
        let controlPoint21 = CGPoint(x: 9/16 * viewSize.width, y: 0)
        let controlPoint22 = CGPoint(x: 9/16 * viewSize.width, y: 3/4 * viewSize.height)
        let endPoint2 = CGPoint(x: 5/8 * viewSize.width, y: 3/16 * viewSize.height)
        path.addCurve(to: endPoint2, controlPoint1: controlPoint21, controlPoint2: controlPoint22)
        let controlPoint31 = CGPoint(x: 11/16 * viewSize.width, y: -3/8 * viewSize.height)
        let controlPoint32 = CGPoint(x: 13/16 * viewSize.width, y: 3/4 * viewSize.height)
        let endPoint3 = CGPoint(x: viewSize.width, y: 1/8 * viewSize.height)
        path.addCurve(to: endPoint3, controlPoint1: controlPoint31, controlPoint2: controlPoint32)
        let bottomRight = CGPoint(x: viewSize.width, y: viewSize.height)
        path.addLine(to: bottomRight)
        // Close path to join to original point
        path.close()
        // Set the background color of the view
        K.red.set()
        path.fill()
    }
    
    private func testCurve(for path: UIBezierPath) {
        // Test to see the curve
        UIColor.black.setStroke()
        path.lineWidth = 1
        path.stroke()
    }
    
}
