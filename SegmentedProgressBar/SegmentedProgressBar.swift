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
    
    var delegate: SegmentedProgressBarDelegate?
    
    var start = true

    
    @IBInspectable var cornerRadius: CGFloat = 0
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = .cyan
    @IBInspectable var circularSegments: Bool = false {
        didSet {
            if(segmentWidth != segmentHeight) {
                circularSegments = false
            }
        }
    }
    
    @IBInspectable var selectedIndex: Int = 0 {
        didSet {
            if(selectedIndex < 0 || selectedIndex > numberOfSegments-1) {
                selectedIndex = 0
            }
        }
    }
    @IBInspectable var selectedColor: UIColor = .black
    @IBInspectable var selectedBorderColor: UIColor = .white

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
                drawSegment(x: leftLineAnchor, direction: DIRECTION_LEFT)
            } else {
                drawSegment(x: rightLineAnchor, direction: DIRECTION_RIGHT)
                if(index < numberOfSegments - 1) {
                    drawLine(direction: DIRECTION_LEFT)
                    drawLine(direction: DIRECTION_RIGHT)
                }
            }
        }
    }
    
    
    
    
    func buildOddSegments() {
        
        drawSegment(x: bounds.midX, direction: START)
        leftLineAnchor = bounds.midX
        rightLineAnchor = bounds.midX
        
        for index in 0..<numberOfSegments-1 {
            if(index % 2 == 0) {
                drawLine(direction: DIRECTION_LEFT)
                drawSegment(x: leftLineAnchor, direction: DIRECTION_LEFT)
            } else {
                drawLine(direction: DIRECTION_RIGHT)
                drawSegment(x: rightLineAnchor, direction: DIRECTION_RIGHT)
            }
        }
    }
    
    func changeSelectedIndex(index: Int) {
        
        segments[selectedIndex].backgroundColor = segmentColor
        segments[selectedIndex].layer.borderColor = borderColor.cgColor

        selectedIndex = index
        segments[selectedIndex].backgroundColor = selectedColor
        segments[selectedIndex].layer.borderColor = selectedBorderColor.cgColor
        if delegate != nil  && start == false{
            delegate?.progressChanged(index: index)
        }
        
    }
    
    
    override func draw(_ rect: CGRect) {
        segments = []
        lines = []
        drawProgressBar()
        
    }
    
    func drawProgressBar() {
        
        if(numberOfSegments % 2 == 0) {
            buildEvenSegments()
        } else {
            buildOddSegments()
        }
        showSegments()
        changeSelectedIndex(index: selectedIndex)
    }
    
    //Creates a new line according to passed direction.
    //Default case:  Builds line centered at midX, midY and updates left and right anchors.
    //Left Direction:  Builds line extending left from leftLineAnchor and updates leftLineAnchor with new minX
    //Right direction: Builds line extending right from rightLineAnchor and updates rughtLineAnchor with new maxX
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
        if(direction == DIRECTION_LEFT) {
            lines.insert(line, at: 0)
        } else {
            lines.append(line)
        }
    }
    
    func customizeSegment(segment: UIView) {
        
        segment.backgroundColor = segmentColor
        segment.layer.borderColor = borderColor.cgColor
        segment.layer.borderWidth = borderWidth
        if(circularSegments) {
            segment.layer.cornerRadius = segmentHeight / 2.0
        } else {
            segment.layer.cornerRadius = cornerRadius
        }
    }
    
    
    //Draw a new segment centered at mid Y and the specified X coordinate.
    func drawSegment(x: CGFloat, direction: Int) {
        
        let segment = UIView(frame: CGRect(x: x - segmentWidth/2,
                                           y: bounds.midY - segmentHeight/2,
                                           width: segmentWidth,
                                           height: segmentHeight))
        customizeSegment(segment: segment)
        
        addSubview(segment)
        if(direction == DIRECTION_LEFT) {
            segments.insert(segment, at: 0)
        } else {
            segments.append(segment)
        }
    }
    
    func increaseProgress() {
        changeSelectedIndex(index: selectedIndex + 1)
    }
    
    func decreaseProgress() {
        changeSelectedIndex(index: selectedIndex - 1)
    }
    
    //Bring all lines to the front
    func showLines() {
        for line in lines {
            bringSubview(toFront:line)
        }
    }
    
    //Bring all segments to the front
    func showSegments() {
        for segment in segments {
            bringSubview(toFront:segment)
        }
    }
    
}












