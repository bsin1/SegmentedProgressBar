//
//  ViewController.swift
//  SegmentedProgressBar
//
//  Created by Balin Sinnott on 5/29/17.
//  Copyright © 2017 Balin Sinnott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SegmentedProgressBarDelegate {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: SegmentedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressBar = SegmentedProgressBar(frame: CGRect(x: 0,
                                                             y: self.view.frame.midY - 100,
                                                             width: self.view.frame.size.width,
                                                             height: 200))
        progressBar.delegate = self
        
        //progressBar.numberOfSegments = 5
        //progressBar.segmentColor = .green
        
        self.view.addSubview(progressBar)
    
        label.text = "Index: \(progressBar.selectedIndex)"
    }
    
    func progressChanged(index: Int) {
        label.text = "Index: \(index)"
    }
    
    @IBAction func increment(_ sender: Any) {
        progressBar.increaseProgress()
    }

    @IBAction func decrement(_ sender: Any) {
        progressBar.decreaseProgress()
    }
}

