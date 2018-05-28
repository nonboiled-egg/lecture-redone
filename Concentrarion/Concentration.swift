//
//  Concentration.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import Foundation
//main Model
struct Concentration{    //class:reference type
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFacedUpCard: Int?{
        get{
            return cards.indices.filter{cards[$0].isFacedUp}.oneAndOnly //CLOSURE DEMO
            
//            var foundIndex:Int?
//            for index in cards.indices{
//                if cards[index].isFacedUp{
//                    if foundIndex == nil{
//                        foundIndex = index
//                    }else{
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set{
            for index in cards.indices{
                cards[index].isFacedUp = (index == newValue) //if it's the only faced up card, keep it up and keep others down
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index),"chooseCard(at: \(index)): chosen card is not in cards array")//error catch
        if !cards[index].isMatched{     //ignore all matched cards
            if !cards[index].isFacedUp{
                flipCount += 1
            }
            
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index{
                //check if match
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }else if cards[matchIndex].isSeen || cards[index].isSeen{
                    score -= 1
                }
                cards[index].isFacedUp = true
                cards[index].isSeen = true
                cards[matchIndex].isSeen = true
                
            }else{
                // 0 or 2
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
        print ("\(cards[index].hashValue)")
    }
    
    mutating func randomDistribution(){
        var temp = [Card]()
        for _ in 0..<cards.count{
            temp.append(cards.remove(at: cards.count.arc4random))
        }
        cards = temp
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,"there must be at least 1 pair of cards.")
        for _ in 1...numberOfPairsOfCards{     //countable range 0...10 -> 0to10 inclusive
            let card = Card()
            cards += [card,card]
        }
        randomDistribution()
    }
}

extension Collection{               //PROTOCOL EXTENSION DEMO
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
        //return condition ? value1(returned if true) : value2(returned if false)
    }
}

//tuple declaration
//1
    //let x: (TYPE1,TYPE2,TYPE3) = (VALUE1,VALUE2,VALUE3)
    //let (NAME1,NAME2,NAME3) = x
    //NAME1 = VALUE1...
//2
    //let x: (NAME1:TYPE1, NAME2:TYPE2, NAME3:TYPE3) = (VALUE1, VALUE2, VALUE3)
    //x.NAME1 = VALUE1...
//3
    //let (NAME1,NAME2,NAME3) = x

//COMPUTED PROPERTY
//var foo{
//  get{return the calculated value of foo}
//  set(NEWVALUE){}//OPTIONAL
//}

//assert
//assert(<#T##condition: Bool##Bool#>,message: String)

//extention
//no storage

//enum declaration VALUE TYPE

    //    enum FastFoodMenuItem{
    //        case hamburger(numberOfPatties:Int)
    //        case frise(size: FryOrderSize)
    //        case drink(String, ounce:Int)
    //        case cookie
    //
    //        mutating func NAME(){
    //            self = .cookie
    //        }
    //    }
    //    enum FryOrderSize{
    //        case large
    //        case small
    //    }
    //
    //    lat menuItem: FastFoodMenuItem = FastFoodMenuItem.humburger(patties: 2)
    //    switch menuItem{
    //      case .humburger: CODE
    //      case .fries, .drink: CODE
    //      default: CODE
    //    }

//ABOUT OPTIONAL
//enum Optional<TYPE>{
//    case none
//    case some(<TYPE>)
//}

//DATA STRUCTURE
    //CLASS
        //reference type
        //inheritance
    //STRUCT
        //value type
        //no inheritance
        //may require "mutating"
    //ENUM
        //refer the note above
    //PROTOCOL
        //WHY:makes API flexible
        //   :sharing functonality
        //HOW:
        //no data storage

//Automatic Referencing Counting
    //strong:   default
    //weak:     if there's no strong pointer, set to nil
    //unknown:  rare(to avoid memory cycle)

//PROTOCOL
    //1. declaration
    //2. class struct enum need to claim
    //3. code

    //@objc -> optional

    //protocol NAME : INHERITED1, INHERITED2 {
    //    CODE
    //}
    //inherited protocols must be inherited to inherit this protocol
    //property must be specified as read only(get) or writable(get set)
    //any func that modifies struct must be mutating(else mark "class" as class only func)
    //if properties inherite the same protocol, they can be in the same array

//DELEGATION
    //1. a view declares a delegation protocol
    //2. the view's api has a weak delegate property whose type is the delegation protocol
    //3. the view uses the delegation property to get/do
    //4. the controller declares to implement the protocol
    //5. the controller sets delegate of the view to itself using he property in 2
    //6. the controller iplements the protocol

//STRING
    //let sampleString = "café pesto"
    //let firstCharacterIndex = sampleString.startIndex
    //let fourthCharIndex = sampleString.index(firstCharacterIndex, offsetBy: 3)
    //let fourthChar = sampleString[fourthCharIndex]
    //
    //if let firstSpace = sampleString.index(of: " "){
    //    let secondWordIndex = sampleString.index(firstSpace, offsetBy: 1)
    //    let secondWord = sampleString[secondWordIndex..<sampleString.endIndex] //chunk of string
    //}
    //split() in python == .components(separatedBy: <#T##CharacterSet#>)
    //ways to look s=through string
        //for char in string{}
        //let arrayName = Array(string)

//NSAttributedString
//let attribute: [NSAttributedStringKey : Any] = [
//    .strokeColor : UIColor.orange
//    .strokeWidth : 5.0            //negative for filling
//]
//let attribtext = NSAttributedString(string: "Flips: 0, attributes: attributes")
//flipCountLabel.attributedText = attribtext
//for mutable, NSMutableAttributedString

//FUNCTION TYPES
    //func changeSign(operand: Double) -> Double{return -operand}
    //var operation = (operand: Double) -> Double {return -operand}
    //var operation = {(operand: Double) -> Double in return -operand}
    //var operation = (operand: Double) {return -operand}
    //var operation = (operand) {return -operand}
    //var operation = {-$0}

//let prime = [2,3,5,7,11]
//let negativePrimes = primes.map({-$0}) //QUESTION: What does $0 represent in this case?
//prime.map(){1/$0}                     //if the last argument of the function is a closure, closure can be out of parentathes
//prime.map{String($0)}                 //if the closure is the only argument, no parentathes
