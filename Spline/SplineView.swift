//
//  SplineView.swift
//  Spline
//
//  Created by balas on 22/10/2015.
//  Copyright © 2015 com.balas. All rights reserved.
//

import Foundation


import Foundation
import UIKit


enum InterpolationType{
  case Hermite
  case CatMull
}


@IBDesignable
class SplineView : UIView{
  
  
  let curve = UIBezierPath()
  let shapeLayer = CAShapeLayer()
  
  var addPointOnTap : Bool = true
  var interpolationType : InterpolationType = .Hermite {
    didSet{
      update()
    }
  }
  
  var controlPoints : [PointView] = []{
    didSet{
      update()
    }
  }
  
  var points : [CGPoint] {
    return controlPoints.map{$0.center}
  }
  
  
  @IBInspectable var contractionFactor : CGFloat = 0.7{
    didSet{
      contractionFactor = min(1, max(0,contractionFactor))
      curve.contractionFactor = contractionFactor
      update()
    }
    
  }
  
  @IBInspectable var pointsList : String = ""{
    didSet{
      
      let points = pointsList.componentsSeparatedByString(";")
      var newPoints : [CGPoint ] = []
      for point in points{
        let coord = point.componentsSeparatedByString(",")
        let newPoint =  CGPoint(x: Int(coord[0])!, y: Int(coord[1])!)
        newPoints.append(newPoint)
      }
      loadWithPoints(newPoints)
      
    }
    
  }
  
  
  
  @IBInspectable var editable : Bool = true {
    didSet{
      for pointView in controlPoints {
        pointView.hidden = !self.editable
      }
      update()
    }
    
  }
  
  @IBInspectable var width : CGFloat = 2.0 {
    
    didSet{
      shapeLayer.lineWidth = width
      update()
    }
    
  }
  
  
  
  @IBInspectable var hermiteInterpolation : Bool = true {
    
    didSet{
      if hermiteInterpolation {
        interpolationType = .Hermite
      }else{
        interpolationType = .CatMull
      }
      update()
    }
    
  }
  
  @IBInspectable var color : UIColor = UIColor.blueColor() {
    
    didSet{
      shapeLayer.strokeColor = color.CGColor
      update()
    }
    
  }
  
  @IBInspectable var patternFill : Int = 1 {
    
    didSet{
      shapeLayer.lineDashPattern = [patternFill,patternSpacing]
      update()
    }
    
  }
  
  @IBInspectable var patternSpacing : Int = 4 {
    
    didSet{
      shapeLayer.lineDashPattern = [patternFill,patternSpacing]
      update()
    }
    
  }
  
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    load()
  }
  
  init(points : [CGPoint], frame : CGRect){
    
    super.init(frame: frame)
    loadWithPoints(points)
    load()
    
  }
  
  required  init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    load()
  }
  
  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    return addPointOnTap
  }
  
  func addPoint(sender: UITapGestureRecognizer) {
    
    let newControl = PointView(point:  sender.locationInView(self))
    self.addSubview(newControl)
    newControl.dragCallBack = { pointView in
      self.update()
    }
    self.controlPoints.append(newControl)
  }
  
  func removePointView(control : PointView){
    
    if let index = self.controlPoints.indexOf(control){
      control.removeFromSuperview()
      self.controlPoints.removeAtIndex(index)
    }
  }
  
  func load(){
    shapeLayer.strokeColor = color.CGColor
    shapeLayer.fillColor = nil
    shapeLayer.lineWidth = width
    shapeLayer.lineJoin = kCALineCapRound
    
    shapeLayer.lineDashPattern = [patternFill,patternSpacing]
    shapeLayer.path = curve.CGPath
    shapeLayer.lineCap = kCALineCapRound
    layer.addSublayer(shapeLayer)
    
    let tap = UITapGestureRecognizer(target: self, action: "addPoint:")
    addGestureRecognizer(tap)
  }
  
  
  func loadWithPoints(points : [CGPoint]){
    
    self.controlPoints.removeAll()
    for point in points {
      if CGRectContainsPoint(CGRect(origin: CGPointZero, size: frame.size),point)
      {
        self.controlPoints.append(PointView(point: point))
      }else{
        print("point \(point) not inside frame")
      }
    }
    for view in subviews{
      view.removeFromSuperview()
    }
    for control in self.controlPoints{
      addSubview(control)
      control.dragCallBack = { pointView in
        self.update()
      }
    }
    update()
  }
  
  
  func update(){
    if controlPoints.count == 0{
      return
    }
    curve.removeAllPoints()
    curve.moveToPoint(points.first!)
    
    if interpolationType == .Hermite{
      curve.interpolatePointsWithHermite( points)
    }else{
      curve.interpolatePointsWithCatMull(points: points)
    }
    shapeLayer.path = curve.CGPath
    setNeedsDisplay()
  }
  
  
  
}