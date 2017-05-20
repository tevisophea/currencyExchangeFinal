//
//  currencyExchange.swift
//  CurrencyExchangeFinal
//
//  Created by user on 5/17/17.
//  Copyright © 2017 Tevisophea. All rights reserved.
//

import Foundation

class currencyExchange {
    
    //MARK: singleton
    static let shared = currencyExchange()
    
    var exchangeName = [" \u{0024} US Dollar", " \u{00A5} Japanese Yen", " \u{17DB} Cambodian Riel", " \u{0E3F} Thailand Baht"]
    
    var listExchanges = ["USDUSD", "USDJPY", "USDKHR", "USDTHB","JPYUSD", "JPYJPY", "JPYKHR", "JPYTHB", "KHRUSD", "KHRJPY", "KHRKHR", "KHRTHB","THBUSD", "THBJPY", "THBKHY", "THBTHB"]
    
    var exchangeDict = [String: Float]()
    var rate: [Float]
    
    var exDict: [String:Float] {
        get {
            return self.exchangeDict
        }
        set {
            exchangeDict = newValue
        }
    }
    
    var rates: [Float] {
        get {
            return self.rate
        }
        set {
            rate = newValue
        }
    }
    
    var currencyName: [String] {
        get {
            return self.listExchanges
        }
    }
    
    init(_ rates: [Float] = [1]) {
        self.rate = rates
    }
    
    
    
    
    
}
