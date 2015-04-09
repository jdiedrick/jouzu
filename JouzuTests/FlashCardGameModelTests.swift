//
//  FlashCardGameModelTests.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/30/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import XCTest
import Jouzu
import Quick
import Nimble


class FlashCardGameModelTests: QuickSpec {
    
    
   override func spec() {
    it("is correct"){

        let myFlashCardGame : FlashCardGameModel = FlashCardGameModel()
        let myFlashCard = FlashCardModel(call: "thank you", response: "ありがとう")
        
        myFlashCardGame.flashCardDeck.addFlashCard(myFlashCard)
        
        expect(myFlashCardGame.respond("ありがとう")).to(beTruthy())
    
        }
    }

}
