//
//  FlashCardGameModelTests.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/30/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import XCTest
import Jouzu

class FlashCardGameModelTests: XCTestCase {

    let myFlashCardGame = FlashCardGameModel()
    let myQuestion = "thank you"
    let myAnswer = "ありがとう"
    let myFlashCard = FlashCardModel(question: "thank you", answer: "ありがとう")

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        myFlashCardGame.flashCardDeck.deck.append(myFlashCard)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGuess(){
        XCTAssert(myFlashCardGame.guessAnswer("ありがとう"), "correct!")
    }

}
