//
//  SwiftLiterals.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-11.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation

enum SwiftBoolLiterals{
    
    case myTrue
    case myFalse
    
}

extension SwiftBoolLiterals: ExpressibleByBooleanLiteral {
    typealias BooleanLiteralType = Bool

    init(booleanLiteral value: Bool) {
        if value {
            self = .myTrue
        }
        else {
            self = .myFalse
            
        }
    }
}

class TestBooleanLiterals{
    func test(value: SwiftBoolLiterals){
        var value2: SwiftBoolLiterals = false
        var value3 = SwiftBoolLiterals(booleanLiteral: false)
        if value3 == .myFalse {
            value2 = true
            value3 = false
        }
    }
    
    func testByStringLiteral(){
        let value: SwiftBoolLiterals = "123"
        print("\(value)")
    }
}

extension SwiftBoolLiterals: ExpressibleByStringLiteral  {
    typealias StringLiteralType = String
    
    init(stringLiteral value: StringLiteralType) {
        if value == "123" {
            self = .myFalse
        }
        else {
            self = .myTrue
        }
    }
}

