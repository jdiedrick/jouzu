//
//  ViewController.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import UIKit

var flashCardGame = FlashCardGameModel()
var callLabel = UILabel()
var responseBox = UITextField()
var respondButton = UIButton()


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
        callLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2, 10, 100, 100))
        callLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].call
        
        self.view.addSubview(callLabel)
        
        //answer label
        responseBox = UITextField(frame: CGRectMake(self.view.frame.size.width/2, 200, 100, 100))
        responseBox.backgroundColor = UIColor.blueColor()
        responseBox.delegate = self
        self.view.addSubview(responseBox)
        
        respondButton = UIButton(frame: CGRectMake(self.view.frame.size.width/2, 300, 100, 100))
        respondButton.backgroundColor = UIColor.orangeColor()
        respondButton.addTarget(self, action: "guessAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(respondButton)
    }
    
    func updateUI(){
        callLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].call
    }
    
    func setupFlashCardGame(){
        flashCardGame.delegate = self
    }
    
    func guessAction(sender:UIButton!){
        flashCardGame.respond(responseBox.text)
        updateUI();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        responseBox.text = textField.text
        flashCardGame.respond(responseBox.text)
        updateUI();
        return false;
    }
    func textFieldDidEndEditing(textField: UITextField) {
        println("\(textField.text)")
    }
    
    func displayAlert(alert: UIAlertController) {
        presentViewController(alert, animated: true, completion: nil)
        responseBox.text = ""
    }
}

