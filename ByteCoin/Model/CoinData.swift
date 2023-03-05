//
//  CoinData.swift
//  ByteCoin
//
//  Created by Pande Adhistanaya on 05/03/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
}
