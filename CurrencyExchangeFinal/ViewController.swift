//
//  ViewController.swift
//  CurrencyExchangeFinal
//
//  Created by user on 5/17/17.
//  Copyright © 2017 Tevisophea. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: Properties
    
    @IBOutlet weak var homePicker: UIPickerView!
    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    
    //using currencyExchange
    let data = currencyExchange.shared
    
    //create variables to display the home and foreign selections
    var homePick: [String] = [String]()
    var foreignPick: [String] = [String]()
    var homeCurr: String = ""
    var foreignCurr: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.homePicker.delegate = self
        self.homePicker.dataSource = self
        
        homePick = ["US Dollar", "Japanese Yen", "Cambodian Riel", "Thailand Baht"]
        foreignPick = ["US Dollar", "Japanese Yen", "Cambodian Riel", "Thailand Baht"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //get data before loading everything else
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        
        if(component == 0)
        {
            return self.homePick.count
        }
        else
        {
            return self.foreignPick.count
        }
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if(component == 0)
        {
            return homePick[row]
        }
        else
        {
            return foreignPick[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if (component == 0) {
                if (String((homePick[row])) == homePick[0]) {
                    homeCurr = "USD"
                } else if (String((homePick[row])) == homePick[1]){
                    homeCurr = "JPY"
                } else if (String((homePick[row])) == homePick[2]){
                    homeCurr = "KHR"
                } else if (String((homePick[row])) == homePick[3]){
                    homeCurr = "THB"
                }
            } else if (component == 1) {
                if (String((foreignPick[row])) == foreignPick[0]) {
                    foreignCurr = "USD"
                } else if (String((foreignPick[row])) == foreignPick[1]){
                    foreignCurr = "JPY"
                } else if (String((foreignPick[row])) == foreignPick[2]){
                    foreignCurr = "KHR"
                } else if (String((foreignPick[row])) == foreignPick[3]){
                    foreignCurr = "THB"
                }
            }
    }

   
    @IBAction func calculateButton(_ sender: Any) {
        if (amountTF.text! != "") {
            //add both currency to grab the conversion code
            let exchangeCurr = homeCurr + foreignCurr
            
            //print out the symbol of the foreign currency
            var currencySymbol: String = ""
            if (foreignCurr == "USD") {
                currencySymbol = "\u{0024}"
            } else if (foreignCurr == "JPY"){
                currencySymbol = "\u{00A5}"
            } else if (foreignCurr == "KHR"){
                currencySymbol = "\u{17DB}"
            } else if (foreignCurr == "THB"){
                currencySymbol = "\u{0E3F}"
            }

            var amount =  Float(self.amountTF.text!)!
            let rate = self.data.exchangeDict[exchangeCurr]!
            amount = amount * rate
            
            amountLabel.text! = currencySymbol + String(amount)
        }
    }
    
    //getData function to grab data from YQL
    func getData() {
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"USDUSD\", \"USDJPY\", \"USDKHR\", \"USDTHB\",\"JPYUSD\", \"JPYJPY\", \"JPYKHR\", \"JPYTHB\", \"KHRUSD\", \"KHRJPY\", \"KHRKHR\", \"KHRTHB\",\"THBUSD\", \"THBJPY\", \"THBKHR\", \"THBTHB\")"
            
            myYQL.query(queryString){ jsonDict in
                //grab each data, repeat until data we need which is ID and RATE
                let queryDict = jsonDict["query"] as! [String: Any]
                let resultDict = queryDict["results"]! as! [String:Any]
                let rateDict = resultDict["rate"]! as! [[String: Any]]
                
                var index = 0
                
                for _ in 0..<16
                {
                    let exName = rateDict[index]["id"] as! String
                    
                    if let exRate = rateDict[index]["Rate"]! as? String
                    {
                        //convert to float
                        let exRateFloat = Float(exRate)
                        self.data.rate.append(exRateFloat!)
                        self.data.exchangeDict[exName]  = exRateFloat!
                    }
                    index = index + 1
                }
            }
        }
    
}

