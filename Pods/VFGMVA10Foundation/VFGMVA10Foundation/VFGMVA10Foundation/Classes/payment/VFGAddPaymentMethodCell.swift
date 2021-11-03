//
//  VFGAddPaymentMethodCell.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 9/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGAddPaymentMethodCell: UICollectionViewCell {
    @IBOutlet weak var addNewPaymentLabel: VFGLabel!

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                layer.borderColor = UIColor.VFGRedOrangeBorder.cgColor
            }
        }
    }

    public func config(labelText: String) {
        addNewPaymentLabel.text = labelText
    }
}
