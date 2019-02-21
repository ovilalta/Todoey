//
//  Item.swift
//  Todoey
//
//  Created by Oscar Vilalta on 1/7/19.
//  Copyright © 2019 Oscar Vilalta. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable {
    var title : String = ""
    var done : Bool = false
}
