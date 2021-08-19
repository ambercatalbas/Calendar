//
//  UIView+Extension.swift
//  DigitalDiary
//
//  Created by Yasemin YEL on 5.08.2021.
//

import UIKit

extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    get { return cornerRadius }
      set {
        self.layer.cornerRadius = newValue
      }
    
  }
  
  
  static var nibName : String {
      return String(describing: self)
  }
  
  static var reuseIdentifier : String {
      return String(describing: self) }

  public var width: CGFloat {
      return frame.size.width
  }
  public var height: CGFloat {
      return frame.size.height
  }
  public var top: CGFloat {
      return frame.origin.y
  }
  public var bottom: CGFloat {
      return frame.origin.y + frame.size.height
  }
  public var left: CGFloat {
      return frame.origin.x
      
  }
  public var right: CGFloat {
      return frame.origin.x + frame.size.width
      
  }
 
}


