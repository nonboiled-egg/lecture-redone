//
//  Card.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import Foundation
struct Card : Hashable
{        //struct:value type(it gets copied when called), no inheritance
    var hashValue : Int{return identifier}
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFacedUp = false
    var isMatched = false
    private var identifier: Int
    var isSeen = false
    
    private static var identifierFactory = 0
    
    init(identifier: Int) {                         //initialized(swift) == constructor(Java,C++)
        self.identifier = identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
}
