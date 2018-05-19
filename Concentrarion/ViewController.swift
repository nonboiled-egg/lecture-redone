//
//  ViewController.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //declaration
    //var NAME(: TYPE) = VALUE
    //func NAME (EXTERNAL INTERNAL:TYPE) -> RETURN-TYPE{CODE}
    
    lazy var game = Concentration(numberOfPairsOfCards: cardButtons.count/2)                          //free init() is created if all var are initialized
    //lazy variables await to intantiate
    
    var flipCount = 0 {                                 //variables must be initiated
        didSet{                                         //property obsever (executes when canged)
            flipCountLabel.text = "\(flipCount) FLIP"   //\() converts to string
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👺","💩","🎃","💍","👽","👾","🤖","🎃","🖕","👹"]
    
    @IBAction func touchCard(_ sender: UIButton) {                      //called when button is touched
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){              //unwrapping optional
            game.chooseCard(at: cardNumber)                             //communication to model
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel(){
        for index in cardButtons.indices{                               // for button in cardButtons dont work cuz button is a let and cant be mutated in the loop
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFacedUp{
                button.setTitle(emoji(for : card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
   
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil, emojiChoices.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))        //no auto type conversion, I have to do it
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return  emoji[card.identifier] ?? "?"
    }
}

