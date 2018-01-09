//
//  concentration.swift
//  concentrationGame
//
//  Created by isha on 06/01/18.
//  Copyright © 2018 isha. All rights reserved.
//

import Foundation

class Concentration {
    private (set) var cards = [Card]()
    
    private(set) var flips = 0
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp  {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        //Setting the cards all face down except indexOfOneAndOnlyFaceUpCard
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        if !cards[index].isMatched {
            flips += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // cards match case
                print(index, indexOfOneAndOnlyFaceUpCard as Any, matchIndex)
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true // not one and only ...
            } else {
                // either no card or two cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            
        }
    }
    
    
    func resetGame() {
        flips = 0
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
    
    init(numberOFPairsOFCards: Int) {
        assert(numberOFPairsOFCards > 0, "Concentration.init(\(numberOFPairsOFCards)): you must have at least one pair of cards")
        for _ in 1...numberOFPairsOFCards {
            let card = Card()
            let matchingCard = card
            cards.append(card)
            cards.append(matchingCard)
        }
        cards.shuffle()
    }
}



extension Array {
    mutating func shuffle() {
        if count < 2 { return }
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i)))
            self.swapAt(i, j)
        }
    }
}

