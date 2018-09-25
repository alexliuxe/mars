//
//  Result.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-05.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation
import UIKit

enum Result<Value, XEError: NSError>{
    case success(Value)
    case failure(XEError)
}

extension Result{
    func resolve() throws -> Value {
        switch self {
        case .failure(let error):
            throw error
        case .success(let value):
            return value
        }
    }
}

class LoadingError: NSError {}

class ImageProcessor {
    typealias Handler = (Result<UIImage, NSError>) -> Void
    
    func process(_ image: UIImage, then handler: @escaping Handler) {
        do {
            // Any error can be thrown here
            let image = UIImage()
            handler(.success(image))
        } catch let error as NSError {
            // When using 'as NSError', Swift will automatically
            // convert any thrown error into an NSError instance
            handler(.failure(error))
        }
    }
    
    func handler(handler: Result<UIImage, NSError>){
        switch handler {
        case .success(let success):
            print(success)
        case .failure(let error):
            print(error)
        }
    }
    
    func testProcess(){
        self.process(UIImage()) { result in
            
        }
        
        self.process(UIImage()) { (result) in
            self.handler(handler: result)
        }
    }
}

class TestResult{
    typealias ErrorHandler = (Result<Data, LoadingError>) -> Void
    
    func load(with request: String, then result: @escaping ErrorHandler){
        
    }
    
    func handleData(_ data: Data){}
    
    func testLoad(){
        self.load(with: "") { [weak self] result in
            switch result {
            case .success(let data):
                self?.handleData(data)
            case .failure(let error):
                print("\(error)fail")
            }
        }
    }
}
