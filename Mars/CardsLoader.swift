//
//  CardsLoader.swift
//  TestProject
//
//  Created by Alex Liu on 2018-09-21.
//  Copyright © 2018 Alex Liu. All rights reserved.
//

import Foundation
import SwiftSoup

class Loader{
    private var sourceString: String = ""
    
    init(){
        self.loadCardsFromHtml()
        //Loader.loadCardsFromDb()
    }
    
    public static func loadCardsFromDb() -> [Card] {
        var cards = Storage.retrieve("cards.json", from: .documents, as: [Card].self)
        let preludes = Storage.retrieve("prelude.json", from: .documents, as: [Card].self)

cards.append(contentsOf: preludes)
        
        return cards
    }
    
    private func loadCardsFromHtml(){
        //load file from mars.html
        let fileURL = Bundle.main.url(forResource:"cards", withExtension: "html")
        do{
            let text = try String(contentsOf: fileURL!, encoding: .utf8)
            self.sourceString = text
            loadCards()
        }
        catch{
            print("Error loading file")
        }
    }
    
    private func loadCards(){
        let indexList = self.sourceString.indexes(of: "<br />")
        
        var newStringArray: [String] = []
        for index in 0..<indexList.count - 1 {
            let subStr = self.sourceString[indexList[index] ..< indexList[index+1]]
            if subStr.count >= 6{
                newStringArray.append(subStr.replacingOccurrences(of: "<br />", with: ""))
            }
        }
        var group: [[String]] = []
        var groupItem: [String] = []
        for str in newStringArray{
            if str == "\n    "{
                if groupItem.count > 0 {
                    group.append(groupItem)
                }
                groupItem = []
                //print("#####")
            }else {
                groupItem.append(str)
                //print("****\(str)")
            }
        }
        
        func getCost(str: String) -> Int{
            if ((str.lowercased().index(of: "cost:")) != nil){
                //this is a cost section
                if str.count > 6 {
                    let cost = str[6 ..< str.count+1]
                    return Int(cost.replacingOccurrences(of: "\n    ", with: ""))!
                }
                return 0
            }else {
                return 0
            }
        }
        
        func getRequirement(s: String) -> [Requirement] {
            
            //split array with space
            let str = s.replacingOccurrences(of: "\n    ", with: "").replacingOccurrences(of: "Requires: ", with: "")
            
            let result = str.split(separator: " ")
            
            if str.contains(str: "o2"){
                ///if o2 and max, then maxo2. otherwise o2

                if str.contains(str: "max"){
                    let num = result[1]
                    return [.maxOxygen(Int(num.replacingOccurrences(of: "%", with: ""))!)]
                }else {
                    let num = result[0]
                    return [.oxygen(Int(num.replacingOccurrences(of: "%", with: ""))!)]
                }
            }else if String(str.last!) == "C"{
                ///if last one is c, if max then max c (split into space) able to get + or -
                if str.contains(str: "max"){
                    let num = result[1]
                    return [.maxTemp(Int(num)!)]
                }else {
                    let num = result[0]
                    return [.minTemp(Int(num)!)]
                }
            }else if str.contains(str: "ocean"){
                ///ocean then space number, if there is a max then maxOcean(3)
                if str.contains(str: "max"){
                    let num = result[2]
                    return [.maxOcean(Int(num)!)]
                }
                else {
                    let num = result[1]
                    return [.minOcean(Int(num)!)]
                }

            }else if str.contains(str: "science") ||
            str.contains(str: "jovian") ||
            str.contains(str: "power") ||
            str.contains(str: "city") ||
                str.contains(str: "earth"){
                
                ///scient with number
                ///if Jovian then number
                ///Power then with number
                ///City then with number
                
                if str.contains(str: "science"){
                    if result.count == 1{
                        return [.tag(type: Tag.science, number: 1)]
                    }else {
                        return [.tag(type: Tag.science, number: Int(result[1])!)]
                    }
                }else if str.contains(str: "earth"){
                    if result.count == 1{
                        return [.tag(type: Tag.earth, number: 1)]
                    }else {
                        return [.tag(type: Tag.earth, number: Int(result[1])!)]
                    }
                }else if str.contains(str: "jovian"){
                    if result.count == 1{
                        return [.tag(type: Tag.jovian, number: 1)]
                    }else {
                        return [.tag(type: Tag.jovian, number: Int(result[1])!)]
                    }
                }else if str.contains(str: "power"){
                    if result.count == 1{
                        return [.tag(type: Tag.power, number: 1)]
                    }else {
                        return [.tag(type: Tag.power, number: Int(result[1])!)]
                    }
                }else if str.contains(str: "city"){
                    if result.count == 1{
                        return [.tag(type: Tag.city, number: 1)]
                    }else {
                        return [.tag(type: Tag.city, number: Int(result[1])!)]
                    }
                }else {
                    return [.none]
                }
            }else if str.contains(str: "titanium production"){
                return [.production(ResourceType.production, Resources.titanium)]
            }
            else if str.contains(str: "steel production"){
                return [.production(ResourceType.production, Resources.building)]
            }
            else if str.contains(str: "greenery tile"){
                return [.plant(1)]
            }
            else if str.contains(str: "plant microbe animal"){
                return [.tag(type: Tag.plant, number: 1), .tag(type: Tag.microbe, number: 1), .tag(type: Tag.animal, number: 1) ]
            }
            else{
                print("requirement tag issue")
                return [.none]
            }
        }
        
        
        var cards: [Card] = []
        
        //which would be each card
        for item in group {
            do {
                
                var card = Card()
                var enconteredSeparator: Bool = false
                for i in 0..<item.count {
                    enconteredSeparator = false
                    //this is name of card
                    if i == 0 { //first one is name
                        let doc: Document = try SwiftSoup.parse(item[i])
                        
                        let sb: Elements = try doc.select("span[style]")
                        let bgColor = sb.array().map { try? $0.attr("style").description }
                        
                        if bgColor[0]!.contains("99FF00"){
                            card.type = .project(.automated)
                        }else if bgColor[0]!.contains("99CCFF"){
                            card.type = .project(.active)
                        }else if bgColor[0]!.contains("FF9900"){
                            card.type = .project(.event)
                        }else{
                            print("failed to load card type")
                        }
                        
                        let bs: Elements = try doc.select("b")
                        if bs.array().count != 2{
                            print("Error, no name or id?")
                        }
                        
                        for i in 0..<bs.array().count{
                            if i == 0{
                                card.cardId = try bs.array()[0].html()
                            }else {
                                card.name = try bs.array()[1].html()
                            }
                        }
                    }
                    else if i == 1 { //tag
                        //if no tag then this is cost
                        
                        if ((item[i].lowercased().index(of: "cost:")) != nil){
                            let cost = getCost(str: item[i])
                            card.cost = cost
                        }else {
                            let doc: Document = try SwiftSoup.parse(item[i])
                            let spans: Elements = try doc.select("span")
                            for s in 0..<spans.array().count where s%2==1 {
                                let html = try spans.array()[s].html()
                                card.tags.append(Tag(rawValue: html.lowercased())!)
                            }
                        }
                    }
                    else if i == 2{ //third one is cost or lines
                        //and not requirement
                        if item[i] != "------\n    "{
                            if item[i].index(of: "Requires: ") != nil
                            {
                                //get requirement
                                let req = getRequirement(s: item[i])
                                card.requirements = req
                            }else {
                                let cost = getCost(str: item[i])
                                card.cost = cost
                            }
                        }else {
                            enconteredSeparator = true
                        }
                    }
                    else if i == 3{ //lines or requirement
                        if item[i] != "------\n    " && !enconteredSeparator {
                            if item[i].index(of: "Requires: ") != nil
                            {
                                let req = getRequirement(s: item[i])
                                card.requirements = req
                            }
                        }
                    }
                    else {
                        //handle it later
                    }
                    
                    //third one is cost if has it
                    //third one is requirement if has it
                    
                    
                    
                    //Oxygen must be
                    //VP: 2
                    //------
                    //Requires: Ocean Ocean Ocean
                    //max 5%
                    //Decrease
                    //Increase
                    //()
                    //Decrease M$ 1
                    //any-
                    //Action:
                    //Special Tile
                    //VP: 1/Ocean*
                    //after ------ TempUp
                    //Titanium Titanium
                    //Ocean Tile Ocean Tile
                    //Remove
                    //des: (Raise temperature 1 step and place an ocean tile. Remove up to 3 <span style="background-color: #51FF00;"><span style="color: #000000;">Plant</span></span>s from any player.)
                    //TempUp
                    //Titanium Titanium Titanium Titanium
                    //12 M$ (Titanium) -&gt; Ocean Tile
                    //(Action: Pay 12 M$ to place an ocean tile. TITANIUM MAY BE USED as if playing a Space card.)
                    //(1 VP for each
                    //-&gt;
                    //background-color: #99CCFF
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                    //
                }
                
                if let separatorIndex = item.firstIndex(of: "------\n    "){
                    if separatorIndex < item.count - 1{
                        for i in separatorIndex+1 ..< item.count {
                            let content = item[i].lowercased()
                            if content.contains(str: "increase"){
                                
                            }else if content.contains(str: "decrease") {
                                
                            }else if content.contains(str: "remove"){
                                
                            }else if content.contains(str: "Special Tile"){
                                
                            }else {
                                let splitedItem = content.split(separator: " ")
                                if content.contains(str: "tempup"){
                                    if splitedItem.count > 1{
                                        let op: OperationResult = .tempUp(Int(splitedItem[1]) ?? 1)
                                        
                                    }
                                }else if content.contains(str: "O2"){
                                }else if content.contains(str: "$$"){
                                }else if content.contains(str: "steel"){
                                }else if content.contains(str: "titanium"){
                                }else if content.contains(str: "energy"){
                                }else if content.contains(str: "plant"){
                                }else if content.contains(str: "heat"){
                                }else if content.contains(str: "tr"){
                                }else if content.contains(str: "greenery Tile"){
                                }else if content.contains(str: "city"){
                                }else if content.contains(str: "card"){
                                }else if content.contains(str: "ocean"){
                                }else if content.contains(str: "microbe"){
                                }else if content.contains(str: "animal"){
                                }
                            }
                        }
                    }
                }else {
                    //should print something
                }
                
                cards.append(card)

            } catch Exception.Error(let type, let message) {
                print(message)
            } catch {
                print("error: parse with exception")
            }
        }
        
        for card in cards {
            print(card.debugDescription)
        }
        
        //manually add last card
        
//        <br /><span style="background-color: #99CCFF;"><b>208</span>:* AI Central</b>
//        <br /><span style="background-color: #FFFFFF;"><span style="color: #000000;">Science</span></span> tag, <span style="background-color: #805700;"><span style="color: #FFFFFF;">Building</span></span> tag
//        <br />Cost: 21
//        <br />Requires: Science 3
//        <br />-&gt; +Card +Card
//        <br />(Action: Draw 2 cards.)
//        <br />------
//        <br />Decrease Energy 1
//        <br />(Requires 3 <span style="background-color: #FFFFFF;"><span style="color: #000000;">Science</span></span> tags to play. Decrease your Energy production 1 step.)
//        <br />VP: 1
//        <br />
        
        var lastCard = Card()
        lastCard.cardId = "208"
        lastCard.name = "* AI Central"
        lastCard.tags = [.science, .building]
        lastCard.cost = 21
        lastCard.requirements = [.tag(type: .science, number: 3)]
        lastCard.vp = 1
        lastCard.type = .project(.active)
        
        cards.append(lastCard)
        //save to database
        
        Storage.store(cards, to: .documents, as: "cards.json")
    }
    
}

extension String{
    func contains(str: String) -> Bool {
        return self.lowercased().index(of: str) != nil
    }
}

extension StringProtocol where Index == String.Index {
    func index<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges<T: StringProtocol>(of string: T, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while start < endIndex, let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.lowerBound < range.upperBound  ? range.upperBound : index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

extension String{
    var isNumeric: Bool {
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        return !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil
    }
    
    
}

public extension String
{
    /**
     Generate date from String.
     */
    public var dateSince1970: Date {
        let interval = TimeInterval((self as NSString).longLongValue)
        return Date(timeIntervalSince1970: interval)
    }
    
    
    /**
     number of characters in string
     */
    public var length: Int
    {
        return self.count
    }
    
    /**
     alias to NSLocalizedString in swift style
     */
    public var localized: String
    {
        return NSLocalizedString(self, comment: "")
    }
    
    /**
     get number of words in string
     */
    public var numberOfWords: Int
    {
        return self.words.count
    }
    
    /**
     remove whitespace and newlines in string
     */
    public var removingWhitespacesAndNewlines: String
    {
        return components(separatedBy: .whitespacesAndNewlines).joined()
    }
    
    /**
     get words in string into an array
     */
    public var words: [String]
    {
        return self.components(separatedBy: " ")
    }
    
    //MARK: Subscript
    
    /**
     get the i th character in string
     */
    public subscript (i: Int) -> String
    {
        return self[(i ..< i + 1)]
    }
    
    /**
     get from i th to the end character in a string
     */
    public func substring(from: Int) -> String
    {
        return self[(min(from, length) ..< length)]
    }
    
    /**
     get start character to i th in a string
     */
    public func substring(to: Int) -> String
    {
        return self[(0 ..< max(0, to))]
    }
    
    public subscript (r: Range<Int>) -> String
    {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[(start ..< end)])
    }
    
    /**
     Construct file path for an archived file with the given file name.
     */
    public static func localFilePath(forFileName name: String) -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard let path = paths.first else {
            fatalError("String extension: localFilePath: a valid file path should always be available. \(paths)")
        }
        return (path as NSString).appendingPathComponent(name)
    }
    
    //MARK: Format validation
    
    /**
     Check String is a valid email format input or not.
     */
    public func isValidEmail() -> Bool
    {
        do
        {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]+$", options: NSRegularExpression.Options.caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
        }
        catch
        {
            return false
        }
    }
    
}

