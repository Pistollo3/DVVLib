//
//  UIView+DashBorder.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 9/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {
    public func addDashedBorder(
        color: UIColor,
        lineWidth: CGFloat,
        lineDashPattern: [NSNumber],
        cornerRadius: CGFloat
    ) {
        let shapeLayer = CAShapeLayer()
        let frameSize = frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width / 2, y: frameSize.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = lineDashPattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath
        layer.addSublayer(shapeLayer)
    }

	@discardableResult
	public func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: UIColor) -> CALayer {
		let borderLayer = CAShapeLayer()
		let cornerRadius = CGSize(width: radius, height: radius)

		layer.sublayers?.forEach { layer in
			if layer is CAShapeLayer {
				layer.removeFromSuperlayer()
			}
		}

		layer.cornerRadius = radius
		layer.masksToBounds = true

		borderLayer.strokeColor = color.cgColor
		borderLayer.lineDashPattern = pattern
		borderLayer.frame = bounds
		borderLayer.fillColor = nil
		borderLayer.path = UIBezierPath(
			roundedRect: bounds,
			byRoundingCorners: .allCorners,
			cornerRadii: cornerRadius
		).cgPath

		layer.addSublayer(borderLayer)
		return borderLayer
	}
}
