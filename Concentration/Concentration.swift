//
//  Concentration.swift
//  Concentration
//
//  Created by Antonio J Rossi on 14/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
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
    
    mutating func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex] == cards[index] {
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
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
            flipCount += 1
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        get {
            return count == 1 ? first : nil
        }
    }
}
