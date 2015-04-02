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
    public var call: String = ""
    public var response: String = ""
    
    public init(call: String, response: String){
        self.call = call
        self.response = response
    }
    
}