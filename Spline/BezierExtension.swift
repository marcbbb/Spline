//
//  BezierExtension.swift
//  Spline
//
//  Created by balas on 22/10/2015.
//  Copyright © 2015 com.balas. All rights reserved.
//

import Foundation
import UIKit

private var _contractionFactor: CGFloat = 0.7


extension UIBezierPath {
  
  class func getAxisAlignedArrowPoints(inout points: Array<CGPoint>, forLength: CGFloat, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat ) {
    
    let tailLength = forLength - headLength
    points.append(CGPointMake(0, tailWidth/2))
    points.append(CGPointMake(tailLength, tailWidth/2))
    points.append(CGPointMake(tailLength, headWidth/2))
    points.append(CGPointMake(forLength, 0))
    points.append(CGPointMake(tailLength, -headWidth/2))
    points.append(CGPointMake(tailLength, -tailWidth/2))
    points.append(CGPointMake(0, -tailWidth/2))
    
  }
  
  
  class func transformForStartPoint(startPoint: CGPoint, endPoint: CGPoint, length: CGFloat) -> CGAffineTransform{
    let cosine: CGFloat = (endPoint.x - startPoint.x)/length
    let sine: CGFloat = (endPoint.y - startPoint.y)/length
    
    return CGAffineTransformMake(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
  }
  
  
  class func bezierPathWithArrowFromPoint(startPoint:CGPoint, endPoint: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> UIBezierPath {
    
    let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
    let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
    let length = hypotf(xdiff, ydiff)
    
    var points = [CGPoint]()
    self.getAxisAlignedArrowPoints(&points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
    
    var transform: CGAffineTransform = self.transformForStartPoint(startPoint, endPoint: endPoint, length:  CGFloat(length))
    
    let cgPath: CGMutablePathRef = CGPathCreateMutable()
    CGPathAddLines(cgPath, &transform, points, 7)
    CGPathCloseSubpath(cgPath)
    
    let uiPath: UIBezierPath = UIBezierPath(CGPath: cgPath)
    return uiPath
  }
}

extension UIBezierPath {
  
  /// The curve‘s bend level. The good value is about 0.6 ~ 0.8. The default and recommended value is 0.7.
  var contractionFactor: CGFloat {
    get {
      return _contractionFactor
    }
    set {
      _contractionFactor = max(0, newValue)
    }
  }
  
  /**
  @param: points Points your bezier wants to through. You must give at least 1 point (different from current point) for drawing curve.
  */
  func interpolatePointsWithCatMull(points points: [CGPoint]) {
    
    assert(points.count > 0, "You must give at least 1 point for drawing the bezier.");
    
    if points.count < 3 {
      
      switch points.count {
        
      case 1:
        addLineToPoint(points[0])
      case 2:
        addLineToPoint(points[1])
      default:
        break
      }
      return
    }
    
    var previousPoint = CGPointZero
    
    var previousCenterPoint = CGPointZero
    var centerPoint = CGPointZero
    var centerPointDistance = CGFloat()
    
    var obliqueAngle = CGFloat()
    
    var previousControlPoint1 = CGPointZero
    var previousControlPoint2 = CGPointZero
    var controlPoint1 = CGPointZero
    
    for var i = 0; i < points.count; i++ {
      
      let pointI = points[i]
      
      if i > 0 {
        
        previousCenterPoint = CenterPointOf(currentPoint, point2: previousPoint)
        centerPoint = CenterPointOf(previousPoint, point2: pointI)
        
        centerPointDistance = DistanceBetween(previousCenterPoint, point2: centerPoint)
        
        obliqueAngle = ObliqueAngleOfStraightThrough(point1:centerPoint, point2:previousCenterPoint)
        
        previousControlPoint2 = CGPoint(x: previousPoint.x - 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), y: previousPoint.y - 0.5 * contractionFactor * centerPointDistance * sin(obliqueAngle))
        controlPoint1 = CGPoint(x: previousPoint.x + 0.5 * contractionFactor * centerPointDistance * cos(obliqueAngle), y: previousPoint.y + 0.5 * contractionFactor * centerPointDistance * sin(obliqueAngle))
      }
      
      switch i {
        
      case 1 :
        
        addQuadCurveToPoint(previousPoint, controlPoint: previousControlPoint2)
        
      case 2 ..< points.count - 1 :
        
        addCurveToPoint(previousPoint, controlPoint1: previousControlPoint1, controlPoint2: previousControlPoint2)
        
      case points.count - 1 :
        
        addCurveToPoint(previousPoint, controlPoint1: previousControlPoint1, controlPoint2: previousControlPoint2)
        addQuadCurveToPoint(pointI, controlPoint: controlPoint1)
        
      default:
        break
      }
      
      previousControlPoint1 = controlPoint1
      previousPoint = pointI
    }
  }
}


extension UIBezierPath
{
  func interpolatePointsWithHermite(interpolationPoints : [CGPoint])
  {
    let n = interpolationPoints.count - 1
    
    for var ii = 0; ii < n; ++ii
    {
      
      var currentPoint = interpolationPoints[ii]
      
      if ii == 0
      {
        self.moveToPoint(interpolationPoints[0])
      }
      
      var nextii = (ii + 1) % interpolationPoints.count
      var previi = (ii - 1 < 0 ? interpolationPoints.count - 1 : ii-1);
      var previousPoint = interpolationPoints[previi]
      var nextPoint = interpolationPoints[nextii]
      let endPoint = nextPoint;
      var mx : Double = 0.0
      var my : Double = 0.0
      
      if ii > 0
      {
        mx = Double(nextPoint.x - currentPoint.x) * 0.5 + Double(currentPoint.x - previousPoint.x) * 0.5;
        my = Double(nextPoint.y - currentPoint.y) * 0.5 + Double(currentPoint.y - previousPoint.y) * 0.5;
      }
      else
      {
        mx = Double(nextPoint.x - currentPoint.x) * 0.5;
        my = Double(nextPoint.y - currentPoint.y) * 0.5;
      }
      
      let controlPoint1 = CGPoint(x: Double(currentPoint.x) + mx / 3.0, y: Double(currentPoint.y) + my / 3.0)
      currentPoint = interpolationPoints[nextii]
      nextii = (nextii + 1) % interpolationPoints.count
      previi = ii;
      previousPoint = interpolationPoints[previi]
      nextPoint = interpolationPoints[nextii]
      
      if ii < n - 1
      {
        mx = Double(nextPoint.x - currentPoint.x) * 0.5 + Double(currentPoint.x - previousPoint.x) * 0.5;
        my = Double(nextPoint.y - currentPoint.y) * 0.5 + Double(currentPoint.y - previousPoint.y) * 0.5;
      }
      else
      {
        mx = Double(currentPoint.x - previousPoint.x) * 0.5;
        my = Double(currentPoint.y - previousPoint.y) * 0.5;
      }
      
      let controlPoint2 = CGPoint(x: Double(currentPoint.x) - mx / 3.0, y: Double(currentPoint.y) - my / 3.0)
      
      self.addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
  }
}
func ObliqueAngleOfStraightThrough(point1 point1: CGPoint, point2: CGPoint) -> CGFloat {    //  [-π/2, 3π/2)
  
  var obliqueRatio: CGFloat = 0
  var obliqueAngle: CGFloat = 0
  
  if (point1.x > point2.x) {
    
    obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x)
    obliqueAngle = atan(obliqueRatio)
  }
  else if (point1.x < point2.x) {
    
    obliqueRatio = (point2.y - point1.y) / (point2.x - point1.x)
    obliqueAngle = CGFloat(M_PI) + atan(obliqueRatio)
  }
  else if (point2.y - point1.y >= 0) {
    
    obliqueAngle = CGFloat(M_PI)/2
  }
  else {
    obliqueAngle = -CGFloat(M_PI)/2
  }
  
  return obliqueAngle
}

func ControlPointForTheBezierCanThrough(point1 point1: CGPoint, point2: CGPoint, point3: CGPoint) -> CGPoint {
  
  return CGPoint(x: (2 * point2.x - (point1.x + point3.x) / 2), y: (2 * point2.y - (point1.y + point3.y) / 2));
}

func DistanceBetween(point1: CGPoint, point2: CGPoint) -> CGFloat {
  
  return sqrt((point1.x - point2.x) * (point1.x - point2.x) + (point1.y - point2.y) * (point1.y - point2.y))
}

func CenterPointOf(point1: CGPoint, point2: CGPoint) -> CGPoint {
  
  return CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
}