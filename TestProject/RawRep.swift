//
//  RawRep.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-11.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import UIKit

enum Color {
    case red
    case blue
    case yellow
}

extension Color: RawRepresentable{
    init?(rawValue: UIColor) {
        switch rawValue {
        case .blue:
            self = Color.blue
        case .red:
            self = Color.red
        case .yellow:
            self = Color.yellow
        default:
        self = Color.blue
        }
    }
    
    var rawValue: UIColor {
        switch self {
        case .red:
            return UIColor.red
        case .yellow:
            return UIColor.yellow
        case .blue:
            return UIColor.blue
        }
    }
    
    typealias RawValue = UIColor
}

class TestXEColor: UIViewController{
    func testColor() -> UIColor? {
        let color = Color(rawValue: UIColor.red)
        return color?.rawValue
    }
    
    
}
