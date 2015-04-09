//
//  FlashCardDeckModel.swift
//  Jouzu
//
//  Created by Johann Diedrick on 3/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

import Foundation

public class FlashCardDeckModel{
    public var deck : [FlashCardModel] = []
    
    public init(){
        
    }
    
    public func addFlashCard(flashcard : FlashCardModel){
        deck.append(flashcard)
    }
}