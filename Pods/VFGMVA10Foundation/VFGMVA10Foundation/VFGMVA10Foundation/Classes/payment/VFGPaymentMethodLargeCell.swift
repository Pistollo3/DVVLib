//
//  VFGPaymentMethodLargeCell.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 9/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGPaymentMethodLargeCell: UICollectionViewCell {
    @IBOutlet weak var cardImageView: VFGImageView!
    @IBOutlet weak var cardNameLabel: VFGLabel!
    @IBOutlet weak var cardNumberLabel: VFGLabel!
    @IBOutlet weak var cardExpiryDateLabel: VFGLabel!

    public func configure(with model: VFGPaymentMethodCellViewModel?) {
        cardImageView.image = model?.cardImage
        cardNameLabel.text = model?.cardName
        cardNumberLabel.text = model?.cardNumber
        cardExpiryDateLabel.text = model?.cardExpiryDate
    }
}
