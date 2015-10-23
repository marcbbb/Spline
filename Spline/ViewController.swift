//
//  ViewController.swift
//  Spline
//
//  Created by balas on 22/10/2015.
//  Copyright © 2015 com.balas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  
  let curve = UIBezierPath()
  let shapeLayer = CAShapeLayer()
  var pointViewArray = [PointView]()
  var spline : SplineView!

  @IBOutlet var splineIB : SplineView!
  @IBOutlet var help : UILabel!
  @IBOutlet var slider : UISlider!
  @IBOutlet var viewProgrammatically : UIView!
  @IBOutlet var viewIB : UIView!
  
  @IBAction func didChange(sender : UISegmentedControl ){
    if sender.selectedSegmentIndex == 0{
      splineIB.interpolationType = .CatMull
      spline.interpolationType = .CatMull
    }else{
      splineIB.interpolationType = .Hermite
      spline.interpolationType = .Hermite
    }
    
  }
  
  @IBAction func didChangeType(sender : UISegmentedControl ){
    if sender.selectedSegmentIndex == 1{
      viewProgrammatically.hidden = false
      viewIB.hidden = true
    }else{
      viewProgrammatically.hidden = true
      viewIB.hidden = false
    }
  
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    help.text = "Drag red control points to edit \n Tap on control point to remove \n Tap any where to add a new point "
    
    var points = [CGPoint]()
    
    for i in 0 ..< 4 {
      points.append(CGPoint(x: i * 60 + 30 + random()%100, y: 60 * i + 300))
    }
    
    spline = SplineView(points: points, frame: self.viewProgrammatically.bounds)
    
    self.viewProgrammatically.addSubview(spline)

  }
  
  @IBAction func sliderValueChanged(slider: UISlider) {
    
    splineIB.contractionFactor = CGFloat( slider.value)
    spline.contractionFactor = CGFloat( slider.value)
  }
}
