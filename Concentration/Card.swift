//
//  Card.swift
//  Concentration
//
//  Created by Antonio J Rossi on 14/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import Foundation

struct Card: Hashable{
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
