//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        coinManager.delegate = self
    }


}

//MARK: - UIPickerViewDataSource, UIPickerViewDelegate

/**
 UIPickerView functionality
 */
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    /**
     determine how many columns
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /**
     determine how many rows
     */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //delegate method
    
    /**
     determine row title
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    /**
     triggered when row is pressed
     */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currency)
    }
}

//MARK: - CoinManagerDelegate

extension ViewController: CoinManagerDelegate {
    /**
     update view labels
     */
    func didUpdateCoinPrice(_ coinManager: CoinManager, _ coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = coinModel.getRateString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    /**
     handle error
     */
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

