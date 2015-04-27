//
//  ViewController.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import UIKit

var flashCardGame = FlashCardGameModel()
var callLabel = UITextView()
var responseBox = UITextField()
var respondButton = UIButton()


class ViewController: UIViewController, UITextFieldDelegate, FlashCardGameModelDelegate {
    
    var delegate: FlashCardGameModelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupFlashCardGame()
        
        setupDB()
        
        setupUI();
        
        setupTap();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Flashcard Game
    func setupFlashCardGame(){
        flashCardGame.delegate = self
    }

    func guessAction(sender:UIButton!){
        flashCardGame.respond(responseBox.text)
        updateUI();
    }
    
    // MARK: DB
    func setupDB(){
        if let rs = FlashCardDatabaseManager.instance.getCallAndResponse(){
            while rs.next() {
                let call = rs.stringForColumn("call")
                let response = rs.stringForColumn("response")
                println("vc call = \(call); vc response = \(response);")
                let card = FlashCardModel(call: call, response: response)
                flashCardGame.flashCardDeck.addFlashCard(card)
            }
        }
    }
    
    // MARK: UI

    func setupUI(){
        //question label
        callLabel = UITextView(frame:
            CGRectMake(
                30,
                (self.view.frame.size.height/2)-30-50,
                self.view.frame.size.width-60,
                50))
        callLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].call
        callLabel.layer.borderColor = UIColor.greenColor().CGColor
        callLabel.layer.borderWidth = 2.0
        callLabel.textContainerInset = UIEdgeInsetsMake(15, 0, 15, 0)
        callLabel.editable = false
        self.view.addSubview(callLabel)
        
        //answer label
        responseBox = UITextField(frame:
            CGRectMake(
            30,
            (self.view.frame.size.height/2)+30,
            self.view.frame.size.width-60,
            50))
        responseBox.layer.borderColor = UIColor.greenColor().CGColor
        responseBox.layer.borderWidth = 2.0
        responseBox.delegate = self
        self.view.addSubview(responseBox)
        
        let midLine = UIView(frame: CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, 3))
        midLine.backgroundColor = UIColor.purpleColor()
       self.view.addSubview(midLine)
        
        /*
        respondButton = UIButton(frame: CGRectMake(self.view.frame.size.width/2, 300, 100, 100))
        respondButton.backgroundColor = UIColor.orangeColor()
        respondButton.addTarget(self, action: "guessAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(respondButton)
        */
    }
    
    func updateUI(){
        callLabel.text = flashCardGame.flashCardDeck.deck[flashCardGame.currentCard].call
    }

    //MARK: Tap Gesture
    
    func setupTap(){
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: TextField Delegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        responseBox.text = textField.text
        flashCardGame.respond(responseBox.text)
        updateUI();
        return false;
    }
    func textFieldDidBeginEditing(textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }

    func textFieldDidEndEditing(textField: UITextField) {
        println("\(textField.text)")
        animateViewMoving(false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        var movementDuration:NSTimeInterval = 0.3
        var movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = CGRectOffset(self.view.frame, 0,  movement)
        UIView.commitAnimations()
    }
   
    // MARK: Alert
    func displayAlert(alert: UIAlertController) {
        presentViewController(alert, animated: true, completion: nil)
        responseBox.text = ""
    }
}