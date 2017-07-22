//
//  SegmentedProgressBar.swift
//  SegmentedProgressBar
//
//  Created by Balin Sinnott on 5/29/17.
//  Copyright © 2017 Balin Sinnott. All rights reserved.
//

import UIKit
@IBDesignable class SegmentedProgressBar: UIView {
    
    enum Direction {
        case start
        case left
        case right
    }
    
    
    var leftLineAnchor: CGFloat = 0
    var rightLineAnchor: CGFloat = 0
    
    
    var segments = [UIView]()
    var lines = [UIView]()
    
    weak var delegate: SegmentedProgressBarDelegate?
    
    var firstLoad = true
    
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
    
    @IBInspectable var numberOfSegments: Int = 2 {
        didSet {
            if(numberOfSegments < 2) {
                numberOfSegments = 2
            }
        }
    }
    
    @IBInspectable var selectedIndex: Int = 0 {
        didSet {
            if(selectedIndex < 0) {
                selectedIndex = 0
            }
            if (selectedIndex > numberOfSegments - 1) {
                selectedIndex = numberOfSegments - 1
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
    
    func buildEvenSegments() {
        
        drawLine(direction: .start)
        
        for index in 0..<numberOfSegments {
            if(index % 2 == 0) {
                drawSegment(x: leftLineAnchor,
                            direction: .left)
            } else {
                drawSegment(x: rightLineAnchor,
                            direction: .right)
                if(index < numberOfSegments - 1) {
                    drawLine(direction: .left)
                    drawLine(direction: .right)
                }
            }
        }
    }
    
    func buildOddSegments() {
        
        drawSegment(x: bounds.midX, direction: .start)
        leftLineAnchor = bounds.midX
        rightLineAnchor = bounds.midX
        
        for index in 0..<numberOfSegments-1 {
            if(index % 2 == 0) {
                drawLine(direction: .left)
                drawSegment(x: leftLineAnchor,
                            direction: .left)
            } else {
                drawLine(direction: .right)
                drawSegment(x: rightLineAnchor,
                            direction: .right)
            }
        }
    }
    
    func changeSelectedIndex(index: Int) {
        
        segments[selectedIndex].backgroundColor = segmentColor
        segments[selectedIndex].layer.borderColor = borderColor.cgColor

        selectedIndex = index
        segments[selectedIndex].backgroundColor = selectedColor
        segments[selectedIndex].layer.borderColor = selectedBorderColor.cgColor
        if delegate != nil  && firstLoad == false {
            delegate?.progressChanged(index: index)
        }
    }
    
    override func draw(_ rect: CGRect) {
        segments = []
        lines = []
        drawProgressBar()
        firstLoad = false

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
    func drawLine(direction: Direction) {
        
        var x: CGFloat = 0
        switch direction {
        case .left:
            x = leftLineAnchor - lineWidth
            leftLineAnchor = x
            break
        case .right:
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
        if(direction == .left) {
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
    func drawSegment(x: CGFloat, direction: Direction) {
        
        let segment = UIView(frame: CGRect(x: x - segmentWidth/2,
                                           y: bounds.midY - segmentHeight/2,
                                           width: segmentWidth,
                                           height: segmentHeight))
        customizeSegment(segment: segment)
        
        addSubview(segment)
        if(direction == .left) {
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



