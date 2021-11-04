//
//  VFGMVA10CurrencyFormatter.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed Fahmy on 04/03/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation


public class VFGMVA10CurrencyFormatter {
    public enum Format: String {
        case comma
        case prefix
        case postfix
    }

    var bundle: Bundle?
    public init(bundle: Bundle?) {
        self.bundle = bundle
    }

    func currencyFormat(
        leftSideSign: Bool = true,
        amount: String,
        sign: String,
        hasComma: Bool = false
    ) -> String {
        let priceFormat = "%1$@%2$@"
        var formattedAmount = amount
        if hasComma {
            formattedAmount = formattedAmount.replacingOccurrences(of: ".", with: ",")
        }
        let currencyStrings = leftSideSign ?  [sign, formattedAmount] : [formattedAmount, sign]
        return String(format: priceFormat, arguments: currencyStrings)
    }

    func buildCurrencyString(
        mode: VFGMVA10CurrencyFormatter.Format?,
        amount: String,
        sign: String
    ) -> String {
        switch mode {
        case .comma?:
            return currencyFormat(
                leftSideSign: false,
                amount: amount,
                sign: sign,
                hasComma: true)

        case .postfix?:
            return currencyFormat(
                leftSideSign: false,
                amount: amount,
                sign: sign,
                hasComma: false)

        case .prefix?:
            return currencyFormat(
                leftSideSign: true,
                amount: amount,
                sign: sign,
                hasComma: false)

        default:
            return currencyFormat(
                leftSideSign: false,
                amount: amount,
                sign: sign,
                hasComma: false)
            }
    }

    public func formatAmountToString(
        amount: String,
        sign: String,
        mode: VFGMVA10CurrencyFormatter.Format? = nil
    ) -> String {
        let keyName = "currency_format_mode"
        let formatModeString = keyName.localized(bundle: bundle)
        let formatMode = VFGMVA10CurrencyFormatter.Format(rawValue: formatModeString)
        return buildCurrencyString(
            mode: mode ?? formatMode,
            amount: amount,
            sign: sign)
    }
}
