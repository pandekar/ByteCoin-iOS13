//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinPrice(_ coinManager: CoinManager, _ coinModel: CoinModel)
    func didFailWithError(_ error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "67B658C0-ACB7-416E-9BAA-6D7E9EF991B6"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        if let url = URL(string: urlString) {
            
            let urlSession = URLSession(configuration: .default)
            
            let task = urlSession.dataTask(with: url) { data, urlResponse, error in
                
                //handle error
                if error != nil {
                    delegate?.didFailWithError(error!)
                    return
                }
                
                //handle data
                if let savedData = data {
                    if let coinInfo = parseJSON(savedData) {
                        delegate?.didUpdateCoinPrice(self, coinInfo)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let coinModel = CoinModel(rate: decodedData.rate, currency: decodedData.asset_id_quote)
            
            return coinModel
        } catch {
            return nil
        }
    }
    
}
