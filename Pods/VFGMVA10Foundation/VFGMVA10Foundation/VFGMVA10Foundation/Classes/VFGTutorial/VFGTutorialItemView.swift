//
//  VFGTutorialItemView.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 6/7/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

class VFGTutorialItemView: UIView {
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var descriptionLabel: VFGLabel!
    @IBOutlet weak var titleToSubTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var tutorialImageView: VFGImageView!

    func configure(
        titleText: String?,
        titleFont: UIFont,
        descriptionText: String?,
        descriptionFont: UIFont,
        titleToSubTitleMargin: CGFloat,
        image: UIImage? = nil
    ) {
        titleLabel.text = titleText
        titleLabel.font = titleFont
        descriptionLabel.text = descriptionText
        descriptionLabel.font = descriptionFont
        titleToSubTitleConstraint.constant = titleToSubTitleMargin
        tutorialImageView.image = image
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
