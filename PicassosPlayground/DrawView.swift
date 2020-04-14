//
//  DrawView.swift
//  PicassosPlayground
//
//  Created by Cody Sugarman on 4/14/20.
//  Copyright © 2020 Cody Sugarman. All rights reserved.
//

import UIKit

class DrawView: UIView {

    var path: UIBezierPath! // this class variable will track each path (two points)
    var startPoint: CGPoint! // this class variable will track the first point in the path
    var movedPoint: CGPoint! // this class variable will track the second point in the path

    var lineColor: UIColor!
    var lineWidth: CGFloat!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startPoint = touch?.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        movedPoint = touch?.location(in: self)
        path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: movedPoint)
        startPoint = movedPoint
        drawLayer()
    }
    
    func drawLayer() {
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.strokeColor = lineColor.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = lineWidth
        self.layer.addSublayer(layer)
        self.setNeedsDisplay()
    }
    
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        lineColor = UIColor.black
        
        if( lineWidth == nil ) {
            lineWidth = 10
        }
    }
    
    func clear() {
        if ( path != nil ) {
            path.removeAllPoints()
            self.layer.sublayers = nil
            self.setNeedsDisplay()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
