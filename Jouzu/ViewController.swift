//
//  ViewController.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import UIKit

var flashCards = FlashCardDeckModel()
var questionLabel = UILabel()
var answerBox = UITextField()

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupFlashcards()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupFlashcards(){
        
        var card1 = FlashCardModel(question: "thank you", answer: "ありがとう")
        var card2 = FlashCardModel(question: "excuse me", answer: "すみません")
        var card3 = FlashCardModel(question: "good afternoon", answer: "こんにちわ")
        flashCards.addFlashCard(card1)
        flashCards.addFlashCard(card2)
        flashCards.addFlashCard(card3)
    }
    

    func setupUI(){
        //question label
        var questionLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2, 10, 100, 100))
        questionLabel.text = flashCards.deck[0].question
        self.view.addSubview(questionLabel)
        
        //answer label
        var answerBox = UITextField(frame: CGRectMake(self.view.frame.size.width/2, 200, 100, 100))
        answerBox.backgroundColor = UIColor.blueColor()
        answerBox.delegate = self
        self.view.addSubview(answerBox)
        
        var guessButton = UIButton(frame: CGRectMake(self.view.frame.size.width/2, 300, 100, 100))
        guessButton.backgroundColor = UIColor.orangeColor()
        guessButton.addTarget(self, action: "guessAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(guessButton)
    }
    
    func guessAction(sender:UIButton!){
        println("answer box text: " + "\(answerBox.text)" + " answer: " + "\(flashCards.deck[0].answer)")
        flashCards.deck[0].guessAnswer(answerBox.text)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        answerBox.text = textField.text
        return false;
    }
    func textFieldDidEndEditing(textField: UITextField) {
        println("\(textField.text)")
    }
}

