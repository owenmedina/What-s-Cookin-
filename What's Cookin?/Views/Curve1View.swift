//
//  Curve1View.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/16/20.
//

import UIKit

class Curve1View: UIView {

    override func draw(_ rect: CGRect) {
            // Card view frame dimensions
            let viewSize = self.bounds.size
            // Get a path to define and traverse
            let path = UIBezierPath()
            // Shift origin to left corner of top straight line
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: viewSize.width, y: 0))
        let controlPoint11 = CGPoint(x: 11/12 * viewSize.width, y: 1/3 * viewSize.height)
        let controlPoint12 = CGPoint(x: 5/12 * viewSize.width, y: 1/8 * viewSize.height)
        let endPoint1 = CGPoint(x: 1/3 * viewSize.width, y: 1/2 * viewSize.height)
        path.addCurve(to: endPoint1, controlPoint1: controlPoint11, controlPoint2: controlPoint12)
        let controlPoint21 = CGPoint(x: 1/4 * viewSize.width, y: 3/4 * viewSize.height)
        let controlPoint22 = CGPoint(x: 1/8 * viewSize.width, y: 7/8 * viewSize.height)
        let endPoint2 = CGPoint(x: 0, y: viewSize.height)
        path.addCurve(to: endPoint2, controlPoint1: controlPoint21, controlPoint2: controlPoint22)
        
        // Test to see the curve
//        UIColor.black.setStroke()
//                path.lineWidth = 1
//                path.stroke()
//            // Sub-curve 1
//        let subcurve1Radius = 1/16 * viewSize.height
//            path.addArc(
//              withCenter: CGPoint(
//                x: 5/9*viewSize.width,
//                y: subcurve1Radius
//              ),
//              radius: subcurve1Radius/2,
//              startAngle: CGFloat(Double.pi * 3 / 2),
//              endAngle: CGFloat(0),
//              clockwise: true
//            )
//
//            // Sub-curve 2
//        path.addCurve(to: <#T##CGPoint#>, controlPoint1: <#T##CGPoint#>, controlPoint2: <#T##CGPoint#>)
//            path.addArc(
//              withCenter: CGPoint(
//                x: viewSize.width - cardRadius,
//                y: effectiveViewHeight - cardRadius
//              ),
//              radius: cardRadius,
//              startAngle: CGFloat(0),
//              endAngle: CGFloat(Double.pi / 2),
//              clockwise: false
//            )
//            // right half of bottom line
//            path.addLine(
//              to: CGPoint(x: viewSize.width / 4 * 3, y: effectiveViewHeight)
//            )
//            // button-slot right arc
//            path.addArc(
//              withCenter: CGPoint(
//                x: viewSize.width / 4 * 3 - buttonSlotRadius,
//                y: effectiveViewHeight
//              ),
//              radius: buttonSlotRadius,
//              startAngle: CGFloat(0),
//              endAngle: CGFloat(Double.pi / 2),
//              clockwise: true
//            )
//
//            // button-slot line
//            path.addLine(
//              to: CGPoint(
//                x: viewSize.width / 4 + buttonSlotRadius,
//                y: effectiveViewHeight + buttonSlotRadius
//              )
//            )
//            // button left arc
//            path.addArc(
//              withCenter: CGPoint(
//                x: viewSize.width / 4 + buttonSlotRadius,
//                y: effectiveViewHeight
//              ),
//              radius: buttonSlotRadius,
//              startAngle: CGFloat(Double.pi / 2),
//              endAngle: CGFloat(Double.pi),
//              clockwise: true
//            )
//            // left half of bottom line
//            path.addLine(
//              to: CGPoint(x: cardRadius, y: effectiveViewHeight)
//            )
//            // bottom-left corner arc
//            path.addArc(
//              withCenter: CGPoint(
//                x: cardRadius,
//                y: effectiveViewHeight - cardRadius
//              ),
//              radius: cardRadius,
//              startAngle: CGFloat(Double.pi / 2),
//              endAngle: CGFloat(Double.pi),
//              clockwise: true
//            )
//            // left line
//            path.addLine(to: CGPoint(x: 0, y: cardRadius))
//            // top-left corner arc
//            path.addArc(
//              withCenter: CGPoint(x: cardRadius, y: cardRadius),
//              radius: cardRadius,
//              startAngle: CGFloat(Double.pi),
//              endAngle: CGFloat(Double.pi / 2 * 3),
//              clockwise: true
//            )
//
            // close path join to origin
            path.close()
            // Set the background color of the view
        
            UIColor(named: "Red")!.set()
            path.fill()
        
//            let fillLayer = CAShapeLayer()
//            fillLayer.path = path.cgPath
//        fillLayer.fillColor = CGColor(red: CGFloat(248), green: CGFloat(72), blue: CGFloat(37), alpha: CGFloat(0))
//            self.layer.addSublayer(fillLayer)
        }

}
