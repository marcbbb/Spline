//
//  PointView.swift
//  Spline
//
//  Created by balas on 22/10/2015.
//  Copyright © 2015 com.balas. All rights reserved.
//

import Foundation

import UIKit

private let EXTENDED_RADIUS: CGFloat = 20
private let RADIUS: CGFloat = 5

class PointView: UIControl {
  
  
  var dragCallBack = { (pointView: PointView) -> Void in }
  
  
  override init(frame : CGRect){
    super.init(frame: frame)
  }
  
  
  override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    return CGRectContainsPoint(CGRectInset(self.bounds, -EXTENDED_RADIUS, -EXTENDED_RADIUS), point);
  }
  
  
  init(point : CGPoint){
    
    
    super.init(frame:  CGRect(origin: CGPointZero, size: CGSize(width: RADIUS * 2, height: RADIUS * 2)))
    self.layer.cornerRadius = RADIUS
    self.center = point
    self.layer.masksToBounds = true
    self.backgroundColor = UIColor.redColor()
    
    let tap = UITapGestureRecognizer(target: self, action: "remove:")
    tap.numberOfTapsRequired = 1
    self.addGestureRecognizer(tap)
    
    self.addTarget(self, action: Selector("touchDragInside:withEvent:"), forControlEvents: .TouchDragInside)
    self.addTarget(self, action: Selector("touchDragInside:withEvent:"), forControlEvents: .TouchDragOutside)
  }
  
  
  func remove(gesture : UIGestureRecognizer){
    if let spline = self.superview as? SplineView{
      spline.removePointView(self)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func touchDragInside(pointView: PointView, withEvent event: UIEvent) {
    
    for touch in event.allTouches()! {
      
      if CGRectContainsPoint(superview!.bounds, touch.locationInView(superview))
      {
        pointView.center = (touch ).locationInView(superview)
        dragCallBack(self)
        return
      }
    }
  }
  
  
}
