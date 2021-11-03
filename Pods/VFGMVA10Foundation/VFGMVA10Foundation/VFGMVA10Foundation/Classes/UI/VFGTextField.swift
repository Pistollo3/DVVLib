//
//  VFGTextField.swift
//  VFGMVA10Foundation
//
//  Created by Esraa Eldaltony on 7/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

/// A UIView contains a UITextField with option of right and left icons and an error view if needed.
public class VFGTextField: UIView, UITextFieldDelegate {
    var textFieldView: VFGGenericTextField?
    public weak var delegate: VFGTextFieldProtocol?
    public weak var dataSource: VFGTextFieldDataSource? {
        didSet {
            if dataSource != nil {
                textFieldView?.updateCustomUI()
            }
        }
    }

    let countryCodeLabelWidthDefault: CGFloat = 50
    /// Space between first letter in text field and border view or country code
    var textFieldLeadingDefault: CGFloat = 14
    var textFieldHintText: String? = ""
    var secondaryPlaceholderText: String? = ""
    var textFieldTipText: String?

    /// Countries textField vars
    var countries: [String] = []
    var isCountryTextField = false
    var pickerView: UIPickerView?
    var toolBar: UIToolbar?
    var placeHolderColor = UIColor.VFGDefaultInputPlaceholderText
    var counterMaxLength: Int?

    // MARK: - public vars

    public var hasError = false
    public var isTextFieldFocused = false
    /// Allowed characters for text field
    public var allowedCharacters: String?
    /// Not allowed characters for text field
    public var notAllowedCharacters: String?
    /// Max number of character allowed in text field
    public var maxLength: Int?

    public var customBackgroundColor: UIColor? {
        dataSource?.customBackgroundColor
    }

    /// Text field value
    public var textFieldText: String {
        get {
            return textFieldView?.textField.text ?? ""
        }
        set {
            textFieldView?.textField.text = newValue
            textFieldView?.topView.isHidden = newValue.isEmpty
            if textFieldView?.counterView.isHidden == false {
                textFieldView?.updateCounterCurrentValue(newValue.count)
            }
            if isCountryTextField {
                delegate?.vfgTextFieldDidEndEditing(self)
            }
        }
    }
    /// Error text shown below text field view
    public var textFieldErrorText: String? {
        get {
            return textFieldView?.errorHintLabel.text
        }
        set {
            textFieldView?.errorHintLabel.text = newValue
        }
    }

    /// Placeholder which move to the top of text field when start typing
    public var textFieldPlaceHolderText: String? {
        get {
            return textFieldHintText
        }
        set {
            textFieldView?.textField.attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
            textFieldHintText = newValue
        }
    }

    /// Placeholder which shown only when user start typing and the hint text move to the top
    public var textFieldSecondaryPlaceholderText: String? {
        get {
            return secondaryPlaceholderText
        }
        set {
            textFieldView?.textField.attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.VFGDefaultInputPlaceholderText])
            secondaryPlaceholderText = newValue
        }
    }

    /// Text field title
    public var textFieldTopTitleText: String? {
        get {
            return textFieldView?.topLabel.text
        }
        set {
            textFieldView?.topLabel.text = newValue
        }
    }
    /// Constants that specify the type of keyboard to display for a text-based view.
    public var textFieldKeyboardType: UIKeyboardType {
        get {
            return textFieldView?.textField.keyboardType ?? UIKeyboardType.default
        }
        set {
            textFieldView?.textField.keyboardType = newValue
        }
    }
    /// Icon in the right text field
    public var textFieldRightIcon: UIImage? {
        get {
            return textFieldView?.rightButton.image(for: .normal)
        }
        set {
            textFieldView?.rightButton.setImage(newValue, for: .normal)
        }
    }

    /// Text field text color
    public var textFieldTextColor: UIColor? {
        get {
            return textFieldView?.textField.textColor
        }
        set {
            textFieldView?.textField.textColor = newValue
        }
    }
    /// Text field text font
    public var textFieldTextFont: UIFont? {
        get {
            return textFieldView?.textField.font
        }
        set {
            textFieldView?.textField.font = newValue
        }
    }
    /// A Boolean value indicating if text field value will be shown as dots like password text field
    public var isSecureTextEntry: Bool {
        get {
            return textFieldView?.textField.isSecureTextEntry ?? false
        }
        set {
            textFieldView?.textField.isSecureTextEntry = newValue
        }
    }

    /// text shown below textfield and it's color changed according to the status
    public var textFieldTipTextEnabled: Bool {
        get {
            return !(textFieldView?.errorHintLabel.isHidden ?? false) && !(textFieldTipText?.isEmpty ?? false)
        }
        set {
            textFieldView?.errorHintLabel.isHidden = !newValue
        }
    }

    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUI()
    }

    public class func loadXib() -> VFGTextField? {
        return Bundle.foundation.loadNibNamed("VFGTextField", owner: self, options: nil)?.first as? VFGTextField
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }


    // MARK: - setup
    public func setTextFieldIdentifier(with identifier: String?) {
        textFieldView?.setTextFieldIdentifier(with: identifier)
    }
    public func setErrorHintLabelIdentifier(with identifier: String?) {
        textFieldView?.setErrorHintLabelIdentifier(with: identifier)
    }
    public func setRightButtonIdentifier(with identifier: String?) {
        textFieldView?.setRightButtonIdentifier(with: identifier)
    }

    func customUI() {
        textFieldView = VFGGenericTextField.loadXib(bundle: Bundle.foundation)
        guard let textFieldView = textFieldView else {
            return
        }
        textFieldView.frame = bounds
        textFieldView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView.textField.delegate = self
        textFieldView.genericTextFieldDelegate = self
        addSubview(textFieldView)
    }
	func setupUI() {
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]

        textFieldView?.errorHintLabel.textColor = .VFGDefaultInputHelperText
        textFieldView?.textField.tintColor = .VFGInputFieldCursor
        textFieldView?.textField.delegate = self

        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingDefault

        textFieldView?.countryCodeLabelWidthConstraint.constant = 0
    }
    /**
    Back to full state when the border is grey and the top title label is hidden and the text field fulled by value

    - Parameter image: The right icon
    */
    public func backToFullState(image: UIImage? = nil) {
        textFieldView?.changeBorderState(to: .full)
        if image != nil {
            textFieldView?.rightButton.setImage(image, for: .normal)
        }
    }
    /// Move to focus state when user starts typing and there the top title label is shown
    public func getFocuesd() {
        textFieldView?.changeBorderState(to: .focus)
    }

    public func hideRightIcon() {
        textFieldView?.rightButton.isHidden = true
        textFieldView?.rightButton.isUserInteractionEnabled = false
    }

    public func showRightIcon() {
        textFieldView?.rightButton.isHidden = false
        textFieldView?.rightButton.isUserInteractionEnabled = true
    }

    public func updateBackgroundColor(with color: UIColor) {
        textFieldView?.backgroundColor = color
        textFieldView?.topView.backgroundColor = color
    }

    public func updateInputFieldBackgroundColor(with color: UIColor) {
        textFieldView?.borderView.backgroundColor = color
    }
}

extension VFGTextField {
    /**
    Show error

    - Parameter title: The error description
    - Parameter font: The text font
    - Parameter textColor: The text color
    - Parameter image: The right icon shown in error case
    - Parameter borderState: The `BorderState`
    */
    public func showError(
        title: String? = nil,
        font: UIFont? = .vodafoneRegular(15),
        textColor: UIColor? = .VFGErrorInputHelperText,
        image: UIImage? = nil,
        borderState: BorderState = .error
    ) {
        textFieldView?.changeBorderState(to: borderState)
        hasError = true
        if image != nil {
            textFieldView?.rightButton.setImage(image, for: .normal)
        }
        if let title = title {
            textFieldView?.errorHintLabel.isHidden = false
            textFieldView?.errorHintLabel.text = title
            textFieldView?.errorHintLabel.font = font
            textFieldView?.errorHintLabel.textColor = textColor
        } else {
            textFieldView?.errorHintLabel.isHidden = true
        }
    }
    /// Hide error
    public func hideError(resetBorderColor: Bool = false) {
        if textFieldTipTextEnabled {
            textFieldView?.errorHintLabel.text = textFieldTipText
            textFieldView?.errorHintLabel.textColor = .VFGDefaultInputHelperText
        } else {
            textFieldView?.errorHintLabel.text = ""
        }
        hasError = false
        if resetBorderColor {
            textFieldView?.changeBorderColor(to: .normal)
        }
    }
}
