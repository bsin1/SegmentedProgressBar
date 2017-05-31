//
//  SegmentedProgressBar.swift
//  SegmentedProgressBar
//
//  Created by Balin Sinnott on 5/29/17.
//  Copyright © 2017 Balin Sinnott. All rights reserved.
//

import UIKit
@IBDesignable class SegmentedProgressBar: UIView {
    
    
    var leftLineAnchor: CGFloat = 0
    var rightLineAnchor: CGFloat = 0
    
    let START = 0
    let DIRECTION_LEFT = -1
    let DIRECTION_RIGHT = -2

    
    var segments = [UIView]()
    var lines = [UIView]()
    
    @IBInspectable var lineWidth: CGFloat  = 100
    @IBInspectable var lineHeight: CGFloat = 3
    @IBInspectable var lineColor: UIColor = .black
    
    @IBInspectable var segmentWidth: CGFloat = 20
    @IBInspectable var segmentHeight: CGFloat = 20
    @IBInspectable var segmentColor: UIColor = .black
    @IBInspectable var numberOfSegments: Int = 2 {
        didSet {
            if(numberOfSegments < 2) {
                numberOfSegments = 2
            }
        }
    }
    
    func buildEvenSegments() {
        
        drawLine(direction: START)
        
        for index in 0..<numberOfSegments {
            if(index % 2 == 0) {
                drawSegment(x: leftLineAnchor)
            } else {
                drawSegment(x: rightLineAnchor)
                if(index < numberOfSegments - 1) {
                    drawLine(direction: DIRECTION_LEFT)
                    drawLine(direction: DIRECTION_RIGHT)
                }
            }
        }

    }
    
    func showLines() {
        for line in lines {
            bringSubview(toFront:line)
        }
    }
    
    func buildOddSegments() {
        
        
    }
    
    
    override func draw(_ rect: CGRect) {
        segments = []
        lines = []
        drawProgressBar()
        
    }
    
    
    func drawLine(direction: Int) {
        
        var x: CGFloat = 0
        switch direction {
        case DIRECTION_LEFT:
            x = leftLineAnchor - lineWidth
            leftLineAnchor = x
            break
        case DIRECTION_RIGHT:
            x = rightLineAnchor
            rightLineAnchor = x + lineWidth
            break
        default:
            x = bounds.midX - lineWidth/2
            leftLineAnchor = x
            rightLineAnchor = bounds.midX + lineWidth/2
        }
        

        let line = UIView(frame: CGRect(x: x,
                                        y: bounds.midY - lineHeight/2,
                                        width: lineWidth,
                                        height: lineHeight))
        line.backgroundColor = lineColor
        addSubview(line)
        lines.append(line)
        
        
    }
    
    
    func drawProgressBar() {
        
        if(numberOfSegments % 2 == 0) {
            buildEvenSegments()
        } else {
            buildOddSegments()
        }
    }
    
    //Draw a new segment centered at mid Y and the specified X coordinate.
    func drawSegment(x: CGFloat) {
        
        let segment = UIView(frame: CGRect(x: x - segmentWidth/2,
                                           y: bounds.midY - segmentHeight/2,
                                           width: segmentWidth,
                                           height: segmentHeight))
        
        segment.backgroundColor = segmentColor
        addSubview(segment)
        segments.append(segment)
        
    }

}












