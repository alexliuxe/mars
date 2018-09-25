//
//  AnyTypeAnyObj.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-11.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation

class AnyTypeTest {
    
    var closure: (Int) -> String = { a in "a" }
    let any: Any = [1,2,3,"func"]
    
    func test(){}
    func test2 (){
        let _: Any = [AnyTypeTest(), 1,2,3]
        
        let closures:Any = [1,3,4,self.closure, "func"]
        
        let _ = "https://xe.com"
    }
}

extension URL: ExpressibleByStringLiteral{
    public typealias StringLiteralType = String
    
    public init(stringLiteral value: StringLiteralType) {
        self = URL(string: value)!
    }
}
