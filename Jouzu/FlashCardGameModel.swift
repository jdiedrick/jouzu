//
//  FlashCardGameModel.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/30/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import Foundation
import UIKit

protocol FlashCardGameModelDelegate{
    func displayAlert(alert: UIAlertController);
}

public class FlashCardGameModel{
    
    public var flashCardDeck : FlashCardDeckModel = FlashCardDeckModel()
    public var currentCard = 0
    var delegate : FlashCardGameModelDelegate?
    var alert = UIAlertController()
    
    public init(){
            
        //var card1 = FlashCardModel(call: "thank you", response: "ありがとう")
        //var card2 = FlashCardModel(call: "excuse me", response: "すみません")
        //var card3 = FlashCardModel(call: "good afternoon", response: "こんにちわ")
        //flashCardDeck.addFlashCard(card1)
        //flashCardDeck.addFlashCard(card2)
        //flashCardDeck.addFlashCard(card3)
        
    }
    
    public func respond(guess: String) -> Bool{
       // println("guess: \(guess) | answer: \(flashCardDeck.deck[currentCard].response)")
        if (guess == flashCardDeck.deck[currentCard].response){
            
            alert = UIAlertController(title: ":)", message: "Soo desu!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Tsugi!", style: UIAlertActionStyle.Default, handler: nil))
            displayAlert(alert)

            currentCard++;
            
            if (currentCard == flashCardDeck.deck.count){
                currentCard=0;
            }
            
            return true
        }else{
            
            alert = UIAlertController(title: ":(", message: "Chigau...", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try again!", style: UIAlertActionStyle.Default, handler: nil))
            displayAlert(alert)

            return false
        }

    }
    
    public func displayAlert(alert: UIAlertController){
        delegate?.displayAlert(alert)
    }
    
    public func startDB(){
        let db = FMDatabase(path: "")

    }

    
}