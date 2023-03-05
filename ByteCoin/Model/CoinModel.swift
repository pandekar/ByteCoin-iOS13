//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Pande Adhistanaya on 05/03/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let rate: Double
    let currency: String
    
    var getRateString: String {
        return String(format: "%.2f", self.rate)
    }
}
