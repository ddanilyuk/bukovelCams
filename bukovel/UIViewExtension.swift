//
//  UIViewExtension.swift
//  bukovel
//
//  Created by Денис Данилюк on 12.01.2020.
//  Copyright © 2020 Денис Данилюк. All rights reserved.
//

import UIKit

extension UIView {
    
    class var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    class var identifier: String {
        return String(describing: self)
    }
}

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}

// Screen height.
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

extension String {
  subscript(value: NSRange) -> Substring {
    return self[value.lowerBound..<value.upperBound]
  }
}

extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
  }

  subscript(value: CountableRange<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
  }

  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    get {
      return self[..<index(at: value.upperBound)]
    }
  }

  subscript(value: PartialRangeThrough<Int>) -> Substring {
    get {
      return self[...index(at: value.upperBound)]
    }
  }

  subscript(value: PartialRangeFrom<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)...]
    }
  }

  func index(at offset: Int) -> String.Index {
    return index(startIndex, offsetBy: offset)
  }
}
