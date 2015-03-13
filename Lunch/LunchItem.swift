//
//  LunchItem.swift
//  Lunch
//
//  Created by Site Equip on 09/03/2015.
//  Copyright (c) 2015 Site Equip. All rights reserved.
//

import Foundation

//We want to be able to add items to our app, so we create our model first.
//Every item needs at least these properties (ie name and quanity)

class Item {
    
    //Instead of using an ititaliser here we have used 2 empty strings
    var name = ""
    //We use a string for quanity as we want to be able to write 200g, 2 packs etc
    var quanity = ""
    var iconName = "Other"
    
}