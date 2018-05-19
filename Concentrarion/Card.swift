//
//  Card.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import Foundation
struct Card{        //struct:value type(it gets copied when called), no inheritance
    var isFacedUp = false
    var isMatched = false
    var identifier: Int
    static var identifierFactory = -1
    
    init(identifier: Int) {                         //initialized(swift) == constructor(Java,C++)
        self.identifier = identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
}
