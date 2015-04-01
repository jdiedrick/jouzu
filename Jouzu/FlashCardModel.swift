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
    
}