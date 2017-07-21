# SegmentedProgressBar
A simple progress bar with customizable segments

# Installation
Copy `SegmentedProgressBar.swift` and `SegmentedProgressBarDelegate.swift` into your project


# Initialization
#### Storyboard

  change class of any `UIView` to `SegmentedProgressBar`.
  
#### Code:

  ```
  let progressBar = SegmentedProgressBar(frame: CGRect(x: 0,
                                                       y: 0,
                                                   width: self.view.frame.size.width,
                                                  height: 200))                         
  self.view.addSubview(progressBar)                                                    
 ```
 
 # Usage
 #### Storyboard
  Edit any of the IBInspectable variables via Interface Builder

  ![](http://imgur.com/cQB8XXW.gif)
  
 #### Customization
  ```
    progressBar.numberOfSegments: Int = 2
    progressBar.segmentWidth: CGFloat = 20
    progressBar.segmentHeight: CGFloat = 20
    progressBar.segmentColor: UIColor = .black
    progressBar.circularSegments: Bool = true //Only works when segmentWidth == segmentHeight
  
    progressBar.cornerRadius: CGFloat = 5
    progressBar.borderWidth: CGFloat = 2
    progressBar.borderColor: UIColor = .green
    
    progressBar.selectedIndex: Int = 0
    progressBar.selectedColor: UIColor = .blue
    progressBar.selectedBorderColor: UIColor = .red
    
    progressBar.lineWidth: CGFloat = 50
    progressBar.lineHeight: CGFloat = 3
    progressBar.lineColor: UIColor = .yellow
  ```
  
  Conform to the `SegmentedProgressBarDelegate` 
  

