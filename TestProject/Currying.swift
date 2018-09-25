//
//  Currying.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-25.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation


typealias Region = (Int) -> (Bool)

class CurryingAndMap{
    
    func testFunc(){
        self.add(a: 2)(3)
        let _ = self.add(a: 3)
    }
    
    @discardableResult
    func add(a: Int) -> Region {
        return {
            x in (x + a) > 10
        }
    }
    
    func add(a: Int, b: Int) -> Bool {
        return a + b > 10
    }
    
    func map<T, Element>(array: [Element], transform: (Element) -> (T)) -> [T]{
        var retArray: [T] = []
        
        for a in array {
            retArray.append(transform(a))
        }
        
        return retArray
    }
    
    
    //reduce
    //flatmap
    //map
    //filter
    
    //simple promise
}

extension Array {
    
    func reduce<T>(_ initial: T, combined: (T, Element) -> T) -> T{
        var ret = initial
        
        for x in self{
            ret = combined(ret, x)
        }
        
        return ret
    }
}
