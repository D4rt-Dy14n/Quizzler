//
//  Store.swift
//  Quizzler-iOS13
//
//  Created by Юрий Федоров on 11.04.2020.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation

struct Store {
    
    let defaults = UserDefaults.standard
    let dictStore: [String:Int]
    
    init(dictStore: [String:Int]) {
        self.dictStore = dictStore
    }
}
