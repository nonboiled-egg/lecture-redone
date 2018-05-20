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
            var foundIndex:Int?
            for index in cards.indices{
                if cards[index].isFacedUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
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
                if cards[matchIndex].identifier == cards[index].identifier{
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
        print ("\(cards[index].identifier)")
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
