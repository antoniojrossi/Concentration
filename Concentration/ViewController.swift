//
//  ViewController.swift
//  Concentration
//
//  Created by Antonio J Rossi on 12/06/2019.
//  Copyright © 2019 Antonio J Rossi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    let themes = [
        ["🎃", "👻", "🦇", "🍭", "🍬", "🍎", "😱", "🙀", "👿", "💀"],
        ["⚽️", "🏀", "🏈", "🏓", "🎾", "🥌", "🏹", "🥊", "🏐", "🥏"],
        ["🐶", "🐱", "🐵", "🐹", "🦊", "🐼", "🐨", "🦁", "🐮", "🐧"],
        ["🍏", "🍐", "🍋", "🍊", "🍌", "🍉", "🍇", "🥝", "🍒", "🍓"],
        ["🏴‍☠️", "🏁", "🏳️‍🌈", "🚩", "🏴", "🏳️", "🇪🇸", "🇬🇷", "🇦🇷", "🇧🇷"],
        ["😀", "🤓", "😅", "😇", "😍", "😛", "☺️", "🥰", "🥳", "😎"],
        ["🚜", "🚡", "🚋", "🛵", "🚲", "🚤", "🚌", "🚗", "🛩", "🚁"]
    ]
    lazy var emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]
    var emoji = [Int: String]()
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChoices = themes[Int(arc4random_uniform(UInt32(themes.count)))]
        emoji = [Int: String]()
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
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
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
