//
//  VFGAccountItemCellViewModel.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 15/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation
import VFGMVA10Foundation
struct VFGAccountItemCellViewModel {
    var account: VFGAccount
    var accountTypeImageName: String
    enum AccountTypeIcon: String {
        init(accountType: VFGUserType) {
            switch accountType {
            case .payG, .payM:
                self = .personal
            case .soho:
                self = .business
            default:
                self = .noIcon
            }
        }
        case personal = "icAdmin"
        case business = "icBusiness"
        case noIcon = ""
    }

    init(account: VFGAccount) {
        self.account = account
        accountTypeImageName = AccountTypeIcon(accountType: self.account.type ?? .payM).rawValue
    }
}
