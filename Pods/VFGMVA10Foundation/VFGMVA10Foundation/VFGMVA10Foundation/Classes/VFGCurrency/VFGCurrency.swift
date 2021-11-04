//
//  VFGCurrency.swift
//  VFGMVA10Group
//
//  Created by Mohamed Sayed on 21/03/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

open class VFGCurrency {
    public weak var delegate: CurrencyFormatterProtocol?
    public var amount: NSNumber
    public var formatted: String? {
        if let externalDelegate = delegate {
            return externalDelegate.getFormattedCurrency(amount)
        } else {
            return getFormattedCurrency(amount)
        }
    }

    public init(amount: NSNumber) {
        self.amount = amount
    }
}

extension VFGCurrency: CurrencyFormatterProtocol {
    public func getFormattedCurrency(_ amount: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let formattedAmount = formatter.string(from: amount as NSNumber) {
            return formattedAmount
        }
        return ""
    }
}
