//
//  Curve1View.swift
//  What's Cookin?
//
//  Created by Owen Medina on 11/16/20.
//

import UIKit

class CurveView: UIView {
    
    override func draw(_ rect: CGRect) {
        // Card view frame dimensions
        let viewSize = self.bounds.size
        // Get a path to define and traverse
        let path = UIBezierPath()
        
        // Start from origin
        // Create first curve which should take up the left 1/2 of the curve view
        path.move(to: CGPoint(x: 0, y: 0))
        let topCenter = CGPoint(x: 1/2 * viewSize.width, y: 0)
        path.addLine(to: topCenter)
        let controlPoint11 = CGPoint(x: 11/24 * viewSize.width, y: 5/24 * viewSize.height)
        let controlPoint12 = CGPoint(x: 5/24 * viewSize.width, y: 5/64 * viewSize.height)
        let endPoint1 = CGPoint(x: 1/6 * viewSize.width, y: 5/16 * viewSize.height)
        path.addCurve(to: endPoint1, controlPoint1: controlPoint11, controlPoint2: controlPoint12)
        let controlPoint21 = CGPoint(x: 1/8 * viewSize.width, y: 15/32 * viewSize.height)
        let controlPoint22 = CGPoint(x: 1/12 * viewSize.width, y: 35/64 * viewSize.height)
        let endPoint2 = CGPoint(x: 0, y: 5/8 * viewSize.height)
        path.addCurve(to: endPoint2, controlPoint1: controlPoint21, controlPoint2: controlPoint22)
        // Close path join to origin
        path.close()
        // Set the background color of the view
        K.Assets.Colors.red.set()
        path.fill()
        
        // Create second curve which should take up the area that starts from the 1/4 of the screen and is 1/3 of the width
        let path2 = UIBezierPath()
        path2.move(to: endPoint1)
        let endPoint3 = CGPoint(x: 5/8 * viewSize.width, y: 25/128 * viewSize.height)
        let controlPoint31 = CGPoint(x: 6/16 * viewSize.width, y: 70/128 * viewSize.height)
        let controlPoint32 = CGPoint(x: 7/16 * viewSize.width, y: 20/128 * viewSize.height)
        path2.addCurve(to: endPoint3, controlPoint1: controlPoint31, controlPoint2: controlPoint32)
        let controlPoint41 = CGPoint(x: 10/16 * viewSize.width, y: 5/64 * viewSize.height)
        let controlPoint42 = CGPoint(x: 4/8 * viewSize.width, y: 15/64 * viewSize.height)
        let endPoint4 = path2.currentPoint
        path2.addCurve(to: topCenter, controlPoint1: controlPoint41, controlPoint2: controlPoint42)
        
        // close curve
        path2.addCurve(to: endPoint1, controlPoint1: controlPoint11, controlPoint2: controlPoint12)
        // Set the background color of the view
        K.Assets.Colors.yellow.set()
        path2.fill()
        
        // Create third curve which should take up the right 1/2 of the curve view
        let path3 = UIBezierPath()
        path3.move(to: topCenter)
        path3.addCurve(to: endPoint4, controlPoint1: controlPoint42, controlPoint2: controlPoint41)
        let endPoint5 = CGPoint(x: 22/32 * viewSize.width, y: 5/8 * viewSize.height)
        let controlPoint51 = CGPoint(x: 9/16 * viewSize.width, y: 7/16 * viewSize.height)
        let controlPoint52 = CGPoint(x: 22/32 * viewSize.width, y: 1/2 * viewSize.height)
        path3.addCurve(to: endPoint5, controlPoint1: controlPoint51, controlPoint2: controlPoint52)
        let endPoint6 = CGPoint(x: viewSize.width, y: viewSize.height)
        let controlPoint61 = CGPoint(x: 11/16 * viewSize.width, y: 30/32 * viewSize.height)
        let controlPoint62 = CGPoint(x: 13/16 * viewSize.width, y: 10/16 * viewSize.height)
        path3.addCurve(to: endPoint6, controlPoint1: controlPoint61, controlPoint2: controlPoint62)
        path3.addLine(to:CGPoint(x: viewSize.width, y: 0))
        path3.close()
        K.Assets.Colors.orange.set()
        path3.fill()
        // Test to see the curve
//                UIColor.black.setStroke()
//                        path3.lineWidth = 1
//                        path3.stroke()
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
        
        
        //            let fillLayer = CAShapeLayer()
        //            fillLayer.path = path.cgPath
        //        fillLayer.fillColor = CGColor(red: CGFloat(248), green: CGFloat(72), blue: CGFloat(37), alpha: CGFloat(0))
        //            self.layer.addSublayer(fillLayer)
    }
    
}
