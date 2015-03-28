//
//  FlashCardModel.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import Foundation
import UIKit

public class FlashCardModel {
    public var question: String = ""
    public var answer: String = ""
    
    
    public init(question: String, answer: String){
        self.question = question
        self.answer = answer
    }
    
    public func guessAnswer(guess: String) -> Bool{
        if (guess == self.answer){
            println("soo desu!")
            return true
        }else{
            println("chigau..")
            return false
        }
    }
}