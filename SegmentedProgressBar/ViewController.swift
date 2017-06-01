//
//  ViewController.swift
//  SegmentedProgressBar
//
//  Created by Balin Sinnott on 5/29/17.
//  Copyright © 2017 Balin Sinnott. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressBar: SegmentedProgressBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Index: \(progressBar.selectedIndex)"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func increment(_ sender: Any) {
        progressBar.increaseProgress()
        label.text = "Index: \(progressBar.selectedIndex)"
    }

    @IBAction func decrement(_ sender: Any) {
        progressBar.decreaseProgress()
        label.text = "Index: \(progressBar.selectedIndex)"
    }
    
    
    
}

