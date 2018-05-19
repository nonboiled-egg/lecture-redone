//
//  ViewController.swift
//  Concentrarion
//
//  Created by Manuarii Ken Tekau Dauphin on 5/18/18.
//  Copyright © 2018 Junya Murakami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "\(flipCount) FLIP"
        }
    }

    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var emojiChoices = ["👺","💩","🎃"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender){
            
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }
        
    }
    
    private func flipCard(withEmoji emoji: String, on button:UIButton){
        if button.currentTitle == emoji{
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        }
    }
    
}

