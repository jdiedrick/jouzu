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
        //setupUI()
        
        //testing db
        
        var isInserted = FlashCardDatabaseManager.instance.addCallAndResponse()
        if isInserted{
            println("is inserted")
            }else{
                println("not inserted")
            }
        
        if let rs = FlashCardDatabaseManager.instance.getCallAndResponse(){
            while rs.next() {
                let call = rs.stringForColumn("call")
                let response = rs.stringForColumn("response")
                // println("vc call = \(x); vc response = \(y);")
                let card = FlashCardModel(call: call, response: response)
                flashCardGame.flashCardDeck.addFlashCard(card)
            }
        }
        
        setupUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupUI(){
        //question label
        callLabel = UILabel(frame: CGRectMake(0, 10, self.view.frame.size.width, 100))
        callLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].call
        
        self.view.addSubview(callLabel)
        
        //answer label
        responseBox = UITextField(frame: CGRectMake(0, 200, self.view.frame.size.width, 100))
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

