//
//  ViewController.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import UIKit

var flashCardGame = FlashCardGameModel()
var questionLabel = UILabel()
var answerBox = UITextField()
var guessButton = UIButton()


class ViewController: UIViewController, UITextFieldDelegate, FlashCardGameModelDelegate {
    
    var delegate: FlashCardGameModelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupFlashCardGame()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI(){
        //question label
        questionLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2, 10, 100, 100))
        questionLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].question
        
        self.view.addSubview(questionLabel)
        
        //answer label
        answerBox = UITextField(frame: CGRectMake(self.view.frame.size.width/2, 200, 100, 100))
        answerBox.backgroundColor = UIColor.blueColor()
        answerBox.delegate = self
        self.view.addSubview(answerBox)
        
        guessButton = UIButton(frame: CGRectMake(self.view.frame.size.width/2, 300, 100, 100))
        guessButton.backgroundColor = UIColor.orangeColor()
        guessButton.addTarget(self, action: "guessAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(guessButton)
    }
    
    func updateUI(){
        questionLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].question
    }
    
    func setupFlashCardGame(){
        flashCardGame.delegate = self
    }
    
    func guessAction(sender:UIButton!){
        flashCardGame.guessAnswer(answerBox.text)
        updateUI();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        answerBox.text = textField.text
        flashCardGame.guessAnswer(answerBox.text)
        updateUI();
        return false;
    }
    func textFieldDidEndEditing(textField: UITextField) {
        println("\(textField.text)")
    }
    
    func displayAlert(alert: UIAlertController) {
        presentViewController(alert, animated: true, completion: nil)
        answerBox.text = ""
    }
}

