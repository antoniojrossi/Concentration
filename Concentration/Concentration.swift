//
//  Concentration.swift
//  Concentration
//
//  Created by Antonio J Rossi on 14/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
    private(set) var flipCount = 0
    private(set) var score = 0
    private var seenCardIndices = [Int]()
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    if seenCardIndices.firstIndex(of: matchIndex) != nil {
                        score -= 1
                    } else {
                        seenCardIndices.append(matchIndex)
                    }
                    if seenCardIndices.firstIndex(of: index) != nil {
                        score -= 1
                    } else {
                        seenCardIndices.append(index)
                    }
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
}
