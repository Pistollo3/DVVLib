//
//  VFGRadioCell.swift
//  VFGMVA10Framework
//
//  Created by Hamsa Hassan on 1/19/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

public class VFGRadioCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var croppedTopSeparator: UIView!
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var iconImageView: VFGImageView!
    @IBOutlet weak var radioButton: VFGRadioButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: CardViewShadow!

    public var onRadioButtonPress: (() -> Void)?
    public var isFirstCell = false
    public var isLastCell = false

    public override var isSelected: Bool {
        didSet {
            radioButton.isSelected = isSelected
        }
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        radioButton.isSelected = selected
    }

    // MARK: Public Methods
    public func setShadow() {
        shadowView.isHidden = false
    }

    public func configure(title: String, imageName: String, isFirstCell: Bool, isLastCell: Bool) {
        self.isFirstCell = isFirstCell
        self.isLastCell = isLastCell

        titleLabel.text = title
        iconImageView.image = VFGImage(named: imageName)
        croppedTopSeparator.isHidden = isFirstCell

        configureConstraints()
        configureCornerRadius()
    }

    // MARK: Actions
    @IBAction func radioButtonDidPress() {
        guard !radioButton.isSelected else {
            return
        }

        onRadioButtonPress?()
    }

    // MARK: Private Methods
    private func configureConstraints() {
        topConstraint.constant = isFirstCell ? 16 : 0
        bottomConstraint.constant = isLastCell ? 6 : 0
    }

    private func configureCornerRadius() {
        var cornersToRound = CACornerMask()

        if isFirstCell {
            cornersToRound.insert(.layerMinXMinYCorner)
            cornersToRound.insert(.layerMaxXMinYCorner)
        }

        if isLastCell {
            cornersToRound.insert(.layerMinXMaxYCorner)
            cornersToRound.insert(.layerMaxXMaxYCorner)
        }

        cardView.layer.maskedCorners = cornersToRound
        cardView.layer.cornerRadius = isFirstCell || isLastCell ? 6.2 : 0
    }
}
