//
//  VFGEditAccountListCell.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 17/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

class VFGEditAccountListCell: UITableViewCell {
    @IBOutlet weak var accountImageView: VFGImageView!
    @IBOutlet weak var accountNameLabel: VFGLabel!
    @IBOutlet weak var deleteButton: VFGButton!

    var deleteButtonDidPress: ((VFGEditAccountListCell) -> Void)?

    func configWith(_ viewModel: VFGAccountItemCellViewModel) {
        accountImageView.image = VFGImage(named: viewModel.accountTypeImageName)
        accountNameLabel.text = viewModel.account.name
    }

    @IBAction func deleteButtonDidPress(_ sender: VFGButton) {
        deleteButtonDidPress?(self)
    }
}
