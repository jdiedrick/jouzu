// Playground - noun: a place where people can play

import UIKit

class FlashCardModel {
    var question: String
    var answer: String
    
    init(question: String, answer: String){
        self.question = question
        self.answer = answer
    }
    
    func guessAnswer(guess: String){
        if (guess == self.answer){
            println("soo desu!")
        }else{
            println("chigau..")
        }
    }
}

let myFlashCard = FlashCardModel(question: "thank you", answer: "ありがとう");

myFlashCard.guessAnswer("ありがとう")
