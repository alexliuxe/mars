//
//  SimplePromiseKit.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-25.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation

class Promis{
    
    // .then { }.then{}
    
    func then<T>(_ next: @escaping (T) -> T) -> (T) -> T {
        return {
            g in next(g)
        }
    }
    
    func test(){}
    
    func test2() {
        
    }
    
    public func userInitiated(_ block: @escaping @convention(block) () -> Swift.Void) {
//        async(block: block, queue: .userInitiated)
    }
    
    public func background(_ block: @escaping @convention(block) () -> Swift.Void) {
//        async(block: block, queue: .background)
    }
    
}
