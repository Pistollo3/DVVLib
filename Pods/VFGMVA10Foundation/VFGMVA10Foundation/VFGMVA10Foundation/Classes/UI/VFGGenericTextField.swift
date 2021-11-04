//
//  VFGGenericTextField.swift
//  VFGMVA10Foundation
//
//  Created by Esraa Eldaltony on 7/1/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

/// A generic UIView with customizable border view, text field and top, bottom hint labels.
class VFGGenericTextField: UIView {
    // MARK: - outlets
    @IBOutlet weak var borderView: UIView!
    /// Contains title label at the top of text field, it will be hidden if textfield is empty.
    @IBOutlet weak var topView: UIView!
    /// The title label at the top of textfield, it will be hidden if textfield is empty.
    @IBOutlet weak var topLabel: VFGLabel!

    /// TextField
    @IBOutlet weak var textField: UITextField!
    /// Right button with icon, can be clickable
    @IBOutlet weak var rightButton: VFGButton!
    @IBOutlet weak var textFieldLeadingConstraints: NSLayoutConstraint!

    /// The label under the text field, can be used as a hint or error label.
    @IBOutlet weak var errorHintLabel: VFGLabel!

    /// The label to the left of the text field, can be used to represent the country code, hidden by default.
    @IBOutlet weak var countryCodeLabel: VFGLabel!
    @IBOutlet weak var countryCodeLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var counterMaxValueLabel: VFGLabel!
    @IBOutlet weak var counterCurrentValueLabel: VFGLabel!

    // MARK: - properties
    weak var genericTextFieldDelegate: VFGGenericTextFieldProtocol?
    private var borderState: BorderState = .normal

    // MARK: - setup
    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    public func setupUI() {
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]

        borderView.cornerRadius = 6.0
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor

        errorHintLabel.isHidden = true
        topView.isHidden = true
        countryCodeLabelWidthConstraint.constant = 0

        textField.addTarget(
            self,
            action: #selector(textFieldDidChange),
            for: .editingChanged)

        if UIView.appearance().semanticContentAttribute == .forceRightToLeft,
            textField.textAlignment != .center {
            textField.textAlignment = .right
        }
    }

    func updateCustomUI() {
        let customColor = genericTextFieldDelegate?.customBackgroundColor ?? .VFGWhiteBackground
        backgroundColor = customColor
        topView.backgroundColor = customColor
    }

    @objc func textFieldDidChange(textField: VFGGenericTextField, text: String) {
        genericTextFieldDelegate?.vfgTextFieldTextChange(textField, text: text)
    }

    @IBAction func rightButtonClicked(_ sender: Any) {
        genericTextFieldDelegate?.vfgTextFieldRightButtonClicked(self)
    }

    // MARK: - border updates
    func changeBorderState(to state: BorderState) {
        changeBorderColor(to: state)
        borderState = state
        topView.isHidden = state == .normal
    }

    func setupCounterView(maxLength: Int?) {
        counterView.isHidden = maxLength == nil
        guard let maxLength = maxLength else {
            return
        }
        counterMaxValueLabel.text = "\(maxLength)"
    }

    func updateCounterCurrentValue(_ count: Int) {
        counterCurrentValueLabel.text = "\(count)"
    }

    func changeBorderColor(to state: BorderState) {
        switch state {
        case .normal:
            borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
            topLabel.textColor = UIColor.VFGDefaultInputLabel
        case .focus:
            borderView.layer.borderColor = UIColor.VFGSelectedInputOutline.cgColor
            topLabel.textColor = UIColor.VFGSelectedInputLabel
        case .error:
            if #available(iOS 13.0, *) {
                let resolvedColor = UIColor.VFGErrorInputOutline.resolvedColor(with: self.traitCollection)
                borderView.layer.borderColor = resolvedColor.cgColor
            } else {
                borderView.layer.borderColor = UIColor.VFGErrorInputOutline.cgColor
            }
            topLabel.textColor = UIColor.VFGErrorInputLabel
        case .full:
            borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
            topLabel.textColor = UIColor.VFGDefaultInputLabel
        }
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                changeBorderColor(to: borderState)
            }
        }
    }

    // MARK: - set identifiers
    func setTextFieldIdentifier(with identifier: String?) {
        textField.accessibilityIdentifier = identifier ?? ""
    }
    func setErrorHintLabelIdentifier(with identifier: String?) {
        errorHintLabel.accessibilityIdentifier = identifier ?? ""
    }
    func setRightButtonIdentifier(with identifier: String?) {
        rightButton.accessibilityIdentifier = identifier ?? ""
    }
}

/// Border state
/// - normal : textfield is empty and not focused
/// - focus : textfield is focused or being edited
/// - error : textfield validation error
/// - full : textfield editing is finished and filled
public enum BorderState: String {
    case normal
    case focus
    case error
    case full
}
