//
//  VFGFilterCell.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 4/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGFilterCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: VFGLabel!
    var filterUnselectedBackgroundColor: UIColor? = .VFGFilterUnselectedBg

    public override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor.VFGFilterSelectedBg: filterUnselectedBackgroundColor
            nameLabel.textColor = isSelected ? UIColor.VFGFilterSelectedText: UIColor.VFGFilterUnselectedText
        }
    }

    public var categoryType: String = "" {
        didSet {
            self.nameLabel.text = categoryType
            self.contentView.setNeedsLayout()
        }
    }

    public override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = self.containerView.frame.height / 2
    }
}
