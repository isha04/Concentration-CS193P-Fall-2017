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
    private(set) var score = 0
    let matchBonus = 2
    let missMatchPenalty = 1
    private var seenCards: Set<Int> = []
    
    
    private var indexOfOneAndOnlyFaceUpCard: Int? //this is made to keep track of case when only one card is up and then a second is chosen and then a match has to be made
//        get {
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp  {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
//        }
//        //Setting the cards all face down except indexOfOneAndOnlyFaceUpCard
//        set {
//            for index in cards.indices {
//                cards[index].isFaceUp = (index == newValue)
//            }
//        }
//
//    }
    
//    func chooseCard1(at index: Int) {
//        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
//        flips += 1
//        if !cards[index].isMatched { //First ignoring all match cards
//
//            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index { //you have something to match
//
//                // case when cards match
//                if cards[matchIndex].identifier == cards[index].identifier {
//                    cards[matchIndex].isMatched = true
//                    cards[index].isMatched = true
//                    score += matchBonus
//                } else {
//                //cards chosen do not match
//                    if seenCards.contains(index) {
//                        score -= missMatchPenalty
//                    }
//                    if seenCards.contains(matchIndex) {
//                        score -= missMatchPenalty
//                    }
//                    seenCards.insert(index)
//                    seenCards.insert(matchIndex)
//                }
//                indexOfOneAndOnlyFaceUpCard = nil
//                cards[index].isFaceUp = true
//            } else {
//                // either no card is faceup or two cards face up, so you cant match
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = index
//            }
//
//        }
//    }


    
    func chooseCard(at index: Int) {
        flips += 1
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index  {
            if cards[matchIndex].identifier == cards[index].identifier {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
                score += matchBonus
            } else {//cards chosen do not match, so deducting
                if seenCards.contains(index) {
                    score -= missMatchPenalty
                }
                if seenCards.contains(matchIndex) {
                    score -= missMatchPenalty
                }
                seenCards.insert(index)
                seenCards.insert(matchIndex)
            }
            cards[index].isFaceUp = true
            indexOfOneAndOnlyFaceUpCard = nil
        } else {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = false
                }
            indexOfOneAndOnlyFaceUpCard = index
            cards[indexOfOneAndOnlyFaceUpCard!].isFaceUp = true
        }
    }
    
    func resetGame() {
        flips = 0
        score = 0
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

