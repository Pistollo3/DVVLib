//
//  VFGPaymentMethodCompactCell.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 9/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGPaymentMethodCompactCell: UICollectionViewCell {
    @IBOutlet weak var cardImageView: VFGImageView!
    @IBOutlet weak var cardNameLabel: VFGLabel!
    @IBOutlet weak var cardNumberLabel: VFGLabel!
    let cardNameFontSize: CGFloat = 18.7
    public var isItemSelected = false {
        didSet {
            isItemSelected ? setupSelectedUI(): setupDeselectedUI()
        }
    }
    public func setupSelectedUI() {
        layer.borderColor = UIColor.VFGActiveSelectionOutline.cgColor
        cardNameLabel.font = UIFont.vodafoneBold(cardNameFontSize)
        layer.borderWidth = 2.1
    }
    public func setupDeselectedUI() {
        layer.borderColor = UIColor.VFGDefaultSelectionOutline.cgColor
        cardNameLabel.font = UIFont.vodafoneRegular(cardNameFontSize)
        layer.borderWidth = 1
    }
    public func configure(with model: VFGPaymentMethodCellViewModel?) {
        cardImageView.image = model?.cardImage
        cardNameLabel.text = model?.cardName
        cardNumberLabel.text = model?.cardNumber
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                isItemSelected ? setupSelectedUI(): setupDeselectedUI()
            }
        }
    }
}
