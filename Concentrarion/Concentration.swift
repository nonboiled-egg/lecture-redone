//
//  Concentration.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import Foundation
//main Model
class Concentration{    //class:reference type
    var cards = [Card]()
    var indexOfOneAndOnlyFacedUpCard: Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched{     //ignore all matched cards
            if let matchIndex = indexOfOneAndOnlyFacedUpCard, matchIndex != index{
                //chech if match
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFacedUpCard = nil
            }else{
                // 0 or 2
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFacedUp = false
                }
                cards[index].isFacedUp = true
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        var temp = [Card]()
        for _ in 0...numberOfPairsOfCards{     //countable range 0...10 -> 0to10 inclusive
            let card = Card()
            temp += [card,card]
        }
        for _ in temp.indices{
            cards.append(temp.remove(at: Int(arc4random_uniform(UInt32(temp.count)))))
        }
        
    }
}
