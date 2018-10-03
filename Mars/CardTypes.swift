//
//  CardTypes.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-21.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation

enum Production: String, Codable {
    case moneyProd
    case steelProd
    case titaniumProd
    case plantProd
    case eneryProd
    case heatProd
}

enum CardType: Codable {
    enum p: Codable {
        
        enum CodingKeys: CodingKey {
            case rawValue
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValue = try container.decode(Int.self, forKey: .rawValue)
            
            switch rawValue {
            case 0:
                self = .automated
            case 1:
                self = .event
            case 2:
                self = .active
            default:
                throw CodingError.unknownValue
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .automated:
                try container.encode(0, forKey: .rawValue)
            case .event:
                try container.encode(1, forKey: .rawValue)
            case .active:
                try container.encode(2, forKey: .rawValue)
            }
        }
        
        case automated
        case event
        case active
    }
    
    enum c: Codable {
        
        enum CodingKeys: CodingKey {
            case rawValue
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValue = try container.decode(Int.self, forKey: .rawValue)
            
            switch rawValue {
            case 0:
                self = .regular
            case 1:
                self = .prelude
            case 2:
                self = .bgg
            case 3:
                self = .venus
            default:
                throw CodingError.unknownValue
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .regular:
                try container.encode(0, forKey: .rawValue)
            case .prelude:
                try container.encode(1, forKey: .rawValue)
            case .bgg:
                try container.encode(2, forKey: .rawValue)
            case .venus:
                try container.encode(3, forKey: .rawValue)
            }
        }
        
        case regular
        case prelude
        case bgg
        case venus
    }
    
    case project(p)
    case prelude
    case corporations(c)
    
    enum CodingKeys: CodingKey {
        case rawValue
        case projectValue
        case corporationsValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .project(let p):
            try container.encode(0, forKey: .rawValue)
            try container.encode(p, forKey: .projectValue)
        case .prelude:
            try container.encode(1, forKey: .rawValue)
        case .corporations(let c):
            try container.encode(2, forKey: .rawValue)
            try container.encode(c, forKey: .corporationsValue)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let pv = try container.decode(p.self, forKey: .projectValue)
            self = .project(pv)
        case 1:
            self = .prelude
        case 2:
            let cp = try container.decode(c.self, forKey: .corporationsValue)
            self = .corporations(cp)
        default:
            throw CodingError.unknownValue
        }
    }
}

extension CardType: Equatable{ }

extension CardType: CustomDebugStringConvertible{
    var debugDescription: String {
        switch self {
        case .prelude:
            return "prelude"
            
        case .project(let p):
            switch p{
            case .active: return "Action/Blue"
            case .automated: return "AutoMated/Green"
            case .event: return "Event/Red"
            }
            
        case .corporations(let c):
            switch c{
            case .bgg: return "bgg"
            case .prelude: return "prelude"
            case .regular : return "traditional"
            case .venus: return "venus"
            }
        }
    }
}

protocol CustomDebugStringProtocol {
    var des: String { get }
}

enum Tag: String, Codable, CustomDebugStringProtocol {
    case power
    case building
    case plant
    case space
    case microbe
    case earth
    case science
    case jovian
    case animal
    case city
    case venus
    case event
    case wild
    
    var des: String{
        return self.rawValue
    }
}

enum Active {
    case effect
    case action
}

enum Requirement: CustomDebugStringProtocol{
    case minTemp(Int)
    case maxTemp(Int)
    case minOcean(Int)
    case titanium(Int)
    case oxygen(Int)
    case maxOxygen(Int)
    case production(ResourceType, Resources)
    case city(Int)
    case maxOcean(Int)
    case plant(Int)
    case tag(type: Tag, number: Int)
    case none
    
    var des: String {
        switch self {
        case .minTemp(let t):
            return "min temp: \(t)"
        case .maxTemp(let t):
            return "max temp: \(t)"
        case .minOcean(let o):
            return "min Ocean: \(o)"
        case .titanium(let t):
            return "titanium: \(t)"
        case .oxygen(let o):
            return "oxygen: \(o)"
        case .maxOxygen(let o):
            return "maxOxygen: \(o)"
        case .production(let resType, let res):
            switch resType{
            case .production:
                return "\(res) production"
            case .resource:
                return "\(res) resource"
            }
        case .city(let c):
            return "city \(c)"
        case .maxOcean(let o):
            return "max ocean \(o)"
        case .plant(let p):
            return "plant: \(p)"
        case .tag(let tag, let number):
            return "\(tag.rawValue): \(number)"
        case .none:
            return "none"
        }
    }
}

extension Requirement: Codable{
    
    enum CodingKeys: CodingKey {
        case rawValue
        case associatedValue
        case resourceTypeValue
        case resource
        case tagValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .minTemp(let value):
            try container.encode(0, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .maxTemp(let value):
            try container.encode(1, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .minOcean(let value):
            try container.encode(2, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .titanium(let value):
            try container.encode(3, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .oxygen(let value):
            try container.encode(4, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .maxOxygen(let value):
            try container.encode(5, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .production(let t, let r):
            try container.encode(6, forKey: .rawValue)
            try container.encode(t, forKey: .resourceTypeValue)
            try container.encode(r, forKey: .resource)
        case .city(let value):
            try container.encode(7, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .maxOcean(let value):
            try container.encode(8, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .plant(let value):
            try container.encode(9, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .tag(let t, let n):
            try container.encode(10, forKey: .rawValue)
            try container.encode(t, forKey: .tagValue)
            try container.encode(n, forKey: .associatedValue)
        case .none:
            try container.encode(11, forKey: .rawValue)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let minTemp = try container.decode(Int.self, forKey: .associatedValue)
            self = .minTemp(minTemp)
        case 1:
            let maxTemp = try container.decode(Int.self, forKey: .associatedValue)
            self = .maxTemp(maxTemp)
        case 2:
            let minOcean = try container.decode(Int.self, forKey: .associatedValue)
            self = .minOcean(minOcean)
        case 3:
            let titanium = try container.decode(Int.self, forKey: .associatedValue)
            self = .titanium(titanium)
        case 4:
            let oxygen = try container.decode(Int.self, forKey: .associatedValue)
            self = .oxygen(oxygen)
        case 5:
            let maxOxygen = try container.decode(Int.self, forKey: .associatedValue)
            self = .maxOxygen(maxOxygen)
        case 6:
            let t = try container.decode(ResourceType.self, forKey: .resourceTypeValue)
            let r = try container.decode(Resources.self, forKey: .resource)
            self = .production(t, r)
        case 7:
            let city = try container.decode(Int.self, forKey: .associatedValue)
            self = .city(city)
        case 8:
            let maxOcean = try container.decode(Int.self, forKey: .associatedValue)
            self = .maxOcean(maxOcean)
        case 9:
            let plant = try container.decode(Int.self, forKey: .associatedValue)
            self = .plant(plant)
        case 10:
            let tag = try container.decode(Tag.self, forKey: .tagValue)
            let tagNum = try container.decode(Int.self, forKey: .associatedValue)
            self = .tag(type: tag, number: tagNum)
        case 11:
            self = .none
        default:
            throw CodingError.unknownValue
        }
    }
}

enum VP: Codable {
    enum CodingKeys: CodingKey {
        case rawValue
        case associatedValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .number(let value):
            try container.encode(0, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .condition(let value):
            try container.encode(1, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let num = try container.decode(Int.self, forKey: .associatedValue)
            self = .number(num)
        case 1:
            let condition = try container.decode(Condition.self, forKey: .associatedValue)
            self = .condition(condition)
        default:
            throw CodingError.unknownValue
        }
    }
    
    enum Condition: Codable{
        
        enum CodingKeys: CodingKey {
            case rawValue
            case associatedValue
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .animal(let value):
                try container.encode(0, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .jovian(let value):
                try container.encode(1, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .city(let value):
                try container.encode(2, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .titanium(let value):
                try container.encode(3, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .microbe(let value):
                try container.encode(4, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .plant(let value):
                try container.encode(5, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .ocean(let value):
                try container.encode(6, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .science(let value):
                try container.encode(7, forKey: .rawValue)
                try container.encode(value, forKey: .associatedValue)
            case .other:
                try container.encode(8, forKey: .rawValue)
            }
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let rawValue = try container.decode(Int.self, forKey: .rawValue)
            
            switch rawValue {
            case 0:
                let animalNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .animal(animalNum)
            case 1:
                let jovianNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .jovian(jovianNum)
            case 2:
                let cityNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .city(cityNum)
            case 3:
                let titaniumNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .titanium(titaniumNum)
            case 4:
                let oxygenNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .microbe(oxygenNum)
            case 5:
                let maxOxygenNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .plant(maxOxygenNum)
            case 6:
                let oceanNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .ocean(oceanNum)
            case 7:
                let scienceNum = try container.decode(Int.self, forKey: .associatedValue)
                self = .science(scienceNum)
            case 8:
                self = .other
            default:
                throw CodingError.unknownValue
            }
        }
        
        case animal(Int)
        case jovian(Int)
        case city(Int)
        case titanium(Int)
        case microbe(Int)
        case plant(Int)
        case ocean(Int)
        case science(Int)
        case other
    }
    
    case number(Int)
    case condition(Condition)
}

enum OperationResult{
    case tempUp(Int)
    case ocean(Int)
    case oxygen(Int)
    case resources(Operation, Resources, ResourceType, Target, number: Int)
    case tr(Int)
    case none
}

extension OperationResult: CustomDebugStringProtocol {
    var des: String {
        switch self {
        case .tempUp(let t):
            return "increase temperature \(t)"
        case .ocean(let o):
            return "place \(o) tiles"
        case .oxygen(let o):
            return "increase oxygen for \(o)"
        case .tr(let t):
            return "get \(t) TR"
        case .none:
            return ""
        case .resources(let o, let res, let type, let target, let num):
            return "\(o.rawValue) \(num) \(res.rawValue) \(type.rawValue) \(target == .any ? "on "+Target.any.rawValue : "")"
        }
    }
}

extension OperationResult: Codable{
    enum CodingKeys: CodingKey {
        case rawValue
        case associatedValue
        case operationValue
        case resourceValue
        case resourceTypeValue
        case targetValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .tempUp(let value):
            try container.encode(0, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .ocean(let value):
            try container.encode(1, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .oxygen(let value):
            try container.encode(2, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .resources(let o, let r, let rt, let t, let n):
            try container.encode(3, forKey: .rawValue)
            try container.encode(o, forKey: .operationValue)
            try container.encode(r, forKey: .resourceValue)
            try container.encode(rt, forKey: .resourceTypeValue)
            try container.encode(t, forKey: .targetValue)
            try container.encode(n, forKey: .associatedValue)
        case .tr(let value):
            try container.encode(4, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue)
        case .none:
            try container.encode(5, forKey: .rawValue)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let value = try container.decode(Int.self, forKey: .associatedValue)
            self = .tempUp(value)
        case 1:
            let value = try container.decode(Int.self, forKey: .associatedValue)
            self = .ocean(value)
        case 2:
            let value = try container.decode(Int.self, forKey: .associatedValue)
            self = .oxygen(value)
            
        case 3:
            let number = try container.decode(Int.self, forKey: .associatedValue)
            let oper = try container.decode(Operation.self, forKey: .operationValue)
            let resource = try container.decode(Resources.self, forKey: .resourceValue)
            let rt = try container.decode(ResourceType.self, forKey: .resourceTypeValue)
            let t = try container.decode(Target.self, forKey: .targetValue)
            self = .resources(oper, resource, rt, t, number: number)
            
        case 4:
            let value = try container.decode(Int.self, forKey: .associatedValue)
            self = .tr(value)
        case 5:
            self = .none
        default:
            throw CodingError.unknownValue
        }
    }
}

enum Target: String, Codable{
    case myself
    case any
}

extension Target: Equatable{}

enum Operation: String, Codable{
    case decrease
    case increase
}

enum Resources: String, Codable{
    case money
    case building
    case titanium
    case energy
    case plant
    case heat
    case tr
    case greeneryTile
    case city
    case card
    case animal
    case microbe
    case ocean
    case oxygen
    case temprature
    case specialTile
}

enum ResourceType: String, Codable{
    case production
    case resource
}

struct Card: Codable {
    var cardId: String
    var name: String
    var type: CardType
    var tags: [Tag]
    var cost: Int
    var vp: Int
    var requirements: [Requirement]
    var result: [OperationResult]
    var resultDes: String
    
    init() {
        self.cardId = "0"
        self.name = ""
        self.type = .prelude
        self.tags = []
        self.cost = 0
        self.vp = 0
        self.requirements = []
        self.result = []
        self.resultDes = ""
    }
}

extension Array where Element: CustomDebugStringProtocol{
    var des: String{
        if self.count == 1 { return self[0].des }
        var retString = ""
        for i in self{
            retString += i.des + "\n "
        }
        
        return retString
    }
}

extension Card: CustomDebugStringConvertible{
    var debugDescription: String {
        return "num: \(self.cardId)  \n" +
            "name \(self.name)  \n" +
            "type: \(self.type.debugDescription)  \n" +
            "tags: \(self.tags.description)  \n" +
            "cost: \(self.cost)  \n" +
            "vp: \(self.vp)  \n" +
            "requirement: \(self.requirements.des)  \n" +
//            "output: \(self.result)  \n" +
        "----------------\n"
    }
}


enum TestCodable: Codable {
    case type1(Int)
    case type2(String, String)
    
    enum CodingKeys: CodingKey {
        case rawValue
        case associatedValue1
        case associatedValue2
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .type1(let value):
            try container.encode(0, forKey: .rawValue)
            try container.encode(value, forKey: .associatedValue1)
        case .type2(let value1, let value2):
            try container.encode(1, forKey: .rawValue)
            try container.encode(value1, forKey: .associatedValue1)
            try container.encode(value2, forKey: .associatedValue2)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        
        switch rawValue {
        case 0:
            let userName = try container.decode(Int.self, forKey: .associatedValue1)
            self = .type1(userName)
        case 1:
            let type1 = try container.decode(String.self, forKey: .associatedValue1)
            let type2 = try container.decode(String.self, forKey: .associatedValue2)
            self = .type2(type1, type2)
        default:
            throw CodingError.unknownValue
        }
    }
}

enum CodingError: Error {
    case unknownValue
}
