//
//  LayoutHelper.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-20.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import UIKit

/// leftAnchor/rightAnchor/leading/trailing == leftAnchor +/- 1
///
///
///
///
///
///
@available(iOS 9.0, *)
public struct SteviaLayoutYAxisAnchor {
    let anchor: NSLayoutYAxisAnchor
    let constant: CGFloat
    
    init(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.anchor = anchor
        self.constant = constant
    }
}

@available(iOS 9.0, *)
public extension UILayoutGuide {
    
    public var Top: SteviaLayoutYAxisAnchor {
        return SteviaLayoutYAxisAnchor(anchor: topAnchor)
    }
    
    public var Bottom: SteviaLayoutYAxisAnchor {
        return SteviaLayoutYAxisAnchor(anchor: bottomAnchor)
    }
}

@available(iOS 9.0, *)
@discardableResult
public func + (left: SteviaLayoutYAxisAnchor, right: CGFloat) -> SteviaLayoutYAxisAnchor {
    return SteviaLayoutYAxisAnchor(anchor: left.anchor, constant: right)
}

class TestNewAutoLayout{
    func test(){
        let view = UIView()
        let view2 = UIView()
        view.leftAnchor
    }
}
//@available(iOS 9.0, *)
//open class NSLayoutAnchor<AnchorType> : NSObject where AnchorType : AnyObject {
//
//
//    /* These methods return an inactive constraint of the form thisAnchor = otherAnchor.
//     */
//    open func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
//
//    open func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
//
//    open func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>) -> NSLayoutConstraint
//
//
//    /* These methods return an inactive constraint of the form thisAnchor = otherAnchor + constant.
//     */
//    open func constraint(equalTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint
//
//    open func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint
//
//    open func constraint(lessThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>, constant c: CGFloat) -> NSLayoutConstraint
//}

