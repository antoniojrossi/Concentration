//
//  ViewController.swift
//  Concentration
//
//  Created by Antonio J Rossi on 12/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOfPairOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
    private let themes = [
        ["🎃", "👻", "🦇", "🍭", "🍬", "🍎", "😱", "🙀", "👿", "💀"],
        ["⚽️", "🏀", "🏈", "🏓", "🎾", "🥌", "🏹", "🥊", "🏐", "🥏"],
        ["🐶", "🐱", "🐵", "🐹", "🦊", "🐼", "🐨", "🦁", "🐮", "🐧"],
        ["🍏", "🍐", "🍋", "🍊", "🍌", "🍉", "🍇", "🥝", "🍒", "🍓"],
        ["🏴‍☠️", "🏁", "🏳️‍🌈", "🚩", "🏴", "🏳️", "🇪🇸", "🇬🇷", "🇦🇷", "🇧🇷"],
        ["😀", "🤓", "😅", "😇", "😍", "😛", "☺️", "🥰", "🥳", "😎"],
        ["🚜", "🚡", "🚋", "🛵", "🚲", "🚤", "🚌", "🚗", "🛩", "🚁"]
    ]
    private lazy var emojiChoices = themes[themes.count.arc4random]
    private var emoji = [Card: String]()
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction private func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairOfCards)
        emojiChoices = themes[themes.count.arc4random]
        emoji = [Card: String]()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        updateFlipCountLabel()
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
        
    }
}
