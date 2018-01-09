//
//  card.swift
//  concentrationGame
//
//  Created by isha on 06/01/18.
//  Copyright © 2018 isha. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
    self.identifier = Card.getUniqueIdentifier()
    }
}
