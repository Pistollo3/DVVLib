//
//  VFGAccountItemCell.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 13/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation
class VFGAccountItemCell: UITableViewCell {
    @IBOutlet weak var accountTypeIcon: VFGImageView!
    @IBOutlet weak var accountNameLabel: VFGLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        accessoryView = VFGImageView(image: VFGImage(named: "icChevronRightRed"))
        accountNameLabel.font = UIFont.vodafoneBold(19)
    }

    func configWith(_ viewModel: VFGAccountItemCellViewModel) {
        accountTypeIcon.image = VFGImage(named: viewModel.accountTypeImageName)
        accountNameLabel.text = viewModel.account.name
    }
}
