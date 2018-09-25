//
//  Layout.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-19.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
extension NSLayoutAnchor{
    
    /* These methods return an inactive constraint of the form thisAnchor = otherAnchor.
     */
    @objc func xeConstraint(equalTo anchor: NSLayoutAnchor<AnchorType>){
        constraint(equalTo: anchor).isActive = true
    }
    
    
    @objc func constraint(greaterThanOrEqualTo anchor: NSLayoutAnchor<AnchorType>){
        self.constraint(greaterThanOrEqualTo: anchor).isActive = true
    }
}

class TestLayout: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.leftAnchor.xeConstraint(equalTo: self.view.leftAnchor)
    }
}
