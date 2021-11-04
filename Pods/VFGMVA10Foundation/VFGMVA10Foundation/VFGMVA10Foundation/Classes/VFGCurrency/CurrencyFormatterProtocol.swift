//
//  CurrencyFormatterProtocol.swift
//  VFGMVA10Group
//
//  Created by Mohamed Sayed on 22/03/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol CurrencyFormatterProtocol: AnyObject {
    func getFormattedCurrency(_ amount: NSNumber) -> String
}
