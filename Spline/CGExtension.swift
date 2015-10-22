//
//  CGExtension.swift
//  Spline
//
//  Created by balas on 22/10/2015.
//  Copyright © 2015 com.balas. All rights reserved.
//

import Foundation
import UIKit

// MARK: operators

/// Returns a point by adding the coordinates of another point.
public func +(p1: CGPoint, p2: CGPoint) -> CGPoint {
  return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
}
/// Modifies the x and y values by adding the coordinates of another point.
public func +=(inout p1: CGPoint, p2: CGPoint) {
  p1.x += p2.x
  p1.y += p2.y
}
/// Returns a point by subtracting the coordinates of another point.
public func -(p1: CGPoint, p2: CGPoint) -> CGPoint {
  return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
}
/// Modifies the x and y values by subtracting the coordinates of another points.
public func -=(inout p1: CGPoint, p2: CGPoint) {
  p1.x -= p2.x
  p1.y -= p2.y
}

/// Returns a point by adding a size to the coordinates.
public func +(point: CGPoint, size: CGSize) -> CGPoint {
  return CGPoint(x: point.x + size.width, y: point.y + size.height)
}
/// Modifies the x and y values by adding a size to the coordinates.
public func +=(inout point: CGPoint, size: CGSize) {
  point.x += size.width
  point.y += size.height
}
/// Returns a point by subtracting a size from the coordinates.
public func -(point: CGPoint, size: CGSize) -> CGPoint {
  return CGPoint(x: point.x - size.width, y: point.y - size.height)
}
/// Modifies the x and y values by subtracting a size from the coordinates.
public func -=(inout point: CGPoint, size: CGSize) {
  point.x -= size.width
  point.y -= size.height
}

/// Returns a point by adding a tuple to the coordinates.
public func +(point: CGPoint, tuple: (CGFloat, CGFloat)) -> CGPoint {
  return CGPoint(x: point.x + tuple.0, y: point.y + tuple.1)
}
/// Modifies the x and y values by adding a tuple to the coordinates.
public func +=(inout point: CGPoint, tuple: (CGFloat, CGFloat)) {
  point.x += tuple.0
  point.y += tuple.1
}
/// Returns a point by subtracting a tuple from the coordinates.
public func -(point: CGPoint, tuple: (CGFloat, CGFloat)) -> CGPoint {
  return CGPoint(x: point.x - tuple.0, y: point.y - tuple.1)
}
/// Modifies the x and y values by subtracting a tuple from the coordinates.
public func -=(inout point: CGPoint, tuple: (CGFloat, CGFloat)) {
  point.x -= tuple.0
  point.y -= tuple.1
}
/// Returns a point by multiplying the coordinates with a value.
public func *(point: CGPoint, factor: CGFloat) -> CGPoint {
  return CGPoint(x: point.x * factor, y: point.y * factor)
}
/// Modifies the x and y values by multiplying the coordinates with a value.
public func *=(inout point: CGPoint, factor: CGFloat) {
  point.x *= factor
  point.y *= factor
}
/// Returns a point by multiplying the coordinates with a tuple.
public func *(point: CGPoint, tuple: (CGFloat, CGFloat)) -> CGPoint {
  return CGPoint(x: point.x * tuple.0, y: point.y * tuple.1)
}
/// Modifies the x and y values by multiplying the coordinates with a tuple.
public func *=(inout point: CGPoint, tuple: (CGFloat, CGFloat)) {
  point.x *= tuple.0
  point.y *= tuple.1
}
/// Returns a point by dividing the coordinates by a tuple.
public func /(point: CGPoint, tuple: (CGFloat, CGFloat)) -> CGPoint {
  return CGPoint(x: point.x / tuple.0, y: point.y / tuple.1)
}
/// Modifies the x and y values by dividing the coordinates by a tuple.
public func /=(inout point: CGPoint, tuple: (CGFloat, CGFloat)) {
  point.x /= tuple.0
  point.y /= tuple.1
}
/// Returns a point by dividing the coordinates by a factor.
public func /(point: CGPoint, factor: CGFloat) -> CGPoint {
  return CGPoint(x: point.x / factor, y: point.y / factor)
}
/// Modifies the x and y values by dividing the coordinates by a factor.
public func /=(inout point: CGPoint, factor: CGFloat) {
  point.x /= factor
  point.y /= factor
}

/// Returns a point by adding another size.
public func +(s1: CGSize, s2: CGSize) -> CGSize {
  return CGSize(width: s1.width + s2.width, height: s1.height + s2.height)
}
/// Modifies the width and height values by adding another size.
public func +=(inout s1: CGSize, s2: CGSize) {
  s1.width += s2.width
  s1.height += s2.height
}
/// Returns a point by subtracting another size.
public func -(s1: CGSize, s2: CGSize) -> CGSize {
  return CGSize(width: s1.width - s2.width, height: s1.height - s2.height)
}
/// Modifies the width and height values by subtracting another size.
public func -=(inout s1: CGSize, s2: CGSize) {
  s1.width -= s2.width
  s1.height -= s2.height
}

/// Returns a point by adding a tuple.
public func +(size: CGSize, tuple: (CGFloat, CGFloat)) -> CGSize {
  return CGSize(width: size.width + tuple.0, height: size.height + tuple.1)
}
/// Modifies the width and height values by adding a tuple.
public func +=(inout size: CGSize, tuple: (CGFloat, CGFloat)) {
  size.width += tuple.0
  size.height += tuple.1
}
/// Returns a point by subtracting a tuple.
public func -(size: CGSize, tuple: (CGFloat, CGFloat)) -> CGSize {
  return CGSize(width: size.width - tuple.0, height: size.height - tuple.1)
}
/// Modifies the width and height values by subtracting a tuple.
public func -=(inout size: CGSize, tuple: (CGFloat, CGFloat)) {
  size.width -= tuple.0
  size.height -= tuple.1
}
/// Returns a point by multiplying the size with a factor.
public func *(size: CGSize, factor: CGFloat) -> CGSize {
  return CGSize(width: size.width * factor, height: size.height * factor)
}
/// Modifies the width and height values by multiplying them with a factor.
public func *=(inout size: CGSize, factor: CGFloat) {
  size.width *= factor
  size.height *= factor
}
/// Returns a point by multiplying the size with a tuple.
public func *(size: CGSize, tuple: (CGFloat, CGFloat)) -> CGSize {
  return CGSize(width: size.width * tuple.0, height: size.height * tuple.1)
}
/// Modifies the width and height values by multiplying them with a tuple.
public func *=(inout size: CGSize, tuple: (CGFloat, CGFloat)) {
  size.width *= tuple.0
  size.height *= tuple.1
}
/// Returns a point by dividing the size by a factor.
public func /(size: CGSize, factor: CGFloat) -> CGSize {
  return CGSize(width: size.width / factor, height: size.height / factor)
}
/// Modifies the width and height values by dividing them by a factor.
public func /=(inout size: CGSize, factor: CGFloat) {
  size.width /= factor
  size.height /= factor
}
/// Returns a point by dividing the size by a tuple.
public func /(size: CGSize, tuple: (CGFloat, CGFloat)) -> CGSize {
  return CGSize(width: size.width / tuple.0, height: size.height / tuple.1)
}
/// Modifies the width and height values by dividing them by a tuple.
public func /=(inout size: CGSize, tuple: (CGFloat, CGFloat)) {
  size.width /= tuple.0
  size.height /= tuple.1
}

/// Returns a rect by adding the coordinates of a point to the origin.
public func +(rect: CGRect, point: CGPoint) -> CGRect {
  return CGRect(origin: rect.origin + point, size: rect.size)
}
/// Modifies the x and y values by adding the coordinates of a point.
public func +=(inout rect: CGRect, point: CGPoint) {
  rect.origin += point
}
/// Returns a rect by subtracting the coordinates of a point from the origin.
public func -(rect: CGRect, point: CGPoint) -> CGRect {
  return CGRect(origin: rect.origin - point, size: rect.size)
}
/// Modifies the x and y values by subtracting the coordinates from a point.
public func -=(inout rect: CGRect, point: CGPoint) {
  rect.origin -= point
}

/// Returns a rect by adding a size to the size.
public func +(rect: CGRect, size: CGSize) -> CGRect {
  return CGRect(origin: rect.origin, size: rect.size + size)
}
/// Modifies the width and height values by adding a size.
public func +=(inout rect: CGRect, size: CGSize) {
  rect.size += size
}
/// Returns a rect by subtracting a size from the size.
public func -(rect: CGRect, size: CGSize) -> CGRect {
  return CGRect(origin: rect.origin, size: rect.size - size)
}
/// Modifies the width and height values by subtracting a size.
public func -=(inout rect: CGRect, size: CGSize) {
  rect.size -= size
}

/// Returns a point by applying a transform.
public func *(point: CGPoint, transform: CGAffineTransform) -> CGPoint {
  return CGPointApplyAffineTransform(point, transform)
}
/// Modifies all values by applying a transform.
public func *=(inout point: CGPoint, transform: CGAffineTransform) {
  point = CGPointApplyAffineTransform(point, transform)
}
/// Returns a size by applying a transform.
public func *(size: CGSize, transform: CGAffineTransform) -> CGSize {
  return CGSizeApplyAffineTransform(size, transform)
}
/// Modifies all values by applying a transform.
public func *=(inout size: CGSize, transform: CGAffineTransform) {
  size = CGSizeApplyAffineTransform(size, transform)
}
/// Returns a rect by applying a transform.
public func *(rect: CGRect, transform: CGAffineTransform) -> CGRect {
  return CGRectApplyAffineTransform(rect, transform)
}
/// Modifies all values by applying a transform.
public func *=(inout rect: CGRect, transform: CGAffineTransform) {
  rect = CGRectApplyAffineTransform(rect, transform)
}

/// Returns a transform by concatenating two transforms.
public func *(t1: CGAffineTransform, t2: CGAffineTransform) -> CGAffineTransform {
  return CGAffineTransformConcat(t1, t2)
}
/// Modifies all values by concatenating another transform.
public func *=(inout t1: CGAffineTransform, t2: CGAffineTransform) {
  t1 = CGAffineTransformConcat(t1, t2)
}


extension UIView {
  
  func resizeToFitSubviews() {
    
    let subviewsRect = subviews.reduce(CGRect.zero) {
      $0.union($1.frame)
    }
    
    let fix = subviewsRect.origin
    
    print("fix : \(fix)")
    
    subviews.forEach {
      $0.frame.offsetInPlace(dx: -fix.x, dy: -fix.y)
    }
    
    frame.offsetInPlace(dx: fix.x, dy: fix.y)
    frame.size = subviewsRect.size
  }
}

extension CGRect{
  
  public init(pointsInside : [CGPoint], expand : CGFloat = 20.0){
    
    
    var origin = pointsInside.first!
    var extrem = pointsInside.first!
    
    for point in pointsInside{
      
      if point.x < origin.x{
        origin = CGPoint(x: point.x, y: origin.y)
      }
      if point.y < origin.y{
        origin = CGPoint(x: origin.x, y: point.y)
      }
      
      if point.x > extrem.x{
        extrem = CGPoint(x: point.x, y: extrem.y)
      }
      if point.y > extrem.y{
        extrem = CGPoint(x: extrem.x, y: point.y)
      }
      
    }
    self.origin = CGPoint(x: origin.x - expand, y: origin.y - expand)
    self.size = CGSize(width: extrem.x - origin.x + 2 * expand, height: extrem.y - origin.y + 2 * expand)
    //print("created rect with \(pointsInside) : \(self) ")
  }
}

