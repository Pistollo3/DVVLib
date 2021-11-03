//
//  VFGTextField+TextFieldDelegates.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 8/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

extension VFGTextField: VFGGenericTextFieldProtocol {
    // MARK: - textFieldDelegate

    public override var inputView: UIView? {
        textFieldView?.textField.inputView
    }

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if isCountryTextField {
            delegate?.vfgTextFieldDidBeginEditing(self)
            return
        }
        isTextFieldFocused = true
        var textFieldLeadingConstraint: CGFloat = textFieldLeadingDefault
        if textFieldView?.countryCodeLabelWidthConstraint.constant != 0 {
            textFieldLeadingConstraint =
                textFieldLeadingDefault + 6 + (textFieldView?.countryCodeLabelWidthConstraint.constant ?? 0)
        }
        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingConstraint

        if textField.text?.isEmpty ?? false {
            textFieldView?.textField.placeholder = self.secondaryPlaceholderText
        } else {
            textFieldView?.textField.placeholder = ""
        }

        textFieldView?.changeBorderState(to: .focus)

        delegate?.vfgTextFieldDidBeginEditing(self)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        isTextFieldFocused = false
        if isCountryTextField { return }
        delegate?.vfgTextFieldDidEndEditing(self)
        if textFieldText.isEmpty {
            resetTextField()
        } else if !hasError {
            textFieldView?.changeBorderState(to: .full)
        }
    }

    public func resetTextField() {
        textFieldText = ""
        var textFieldLeadingConstraint: CGFloat = 14
        if textFieldView?.countryCodeLabelWidthConstraint.constant != 0 {
            textFieldLeadingConstraint =
                textFieldLeadingDefault + 6 + (textFieldView?.countryCodeLabelWidthConstraint.constant ?? 0)
        }
        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingConstraint
        textFieldView?.textField.placeholder = textFieldHintText
        textFieldView?.changeBorderState(to: .normal)
    }

    public func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if isCountryTextField {
            return false
        }
        // Allowed Characters Validation
        if let allowedCharacters = allowedCharacters {
            let allowedCharacters = CharacterSet(charactersIn: allowedCharacters)
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
        }

        // Not Allowed Characters Validation
        if let notAllowedCharacters = notAllowedCharacters {
            let notAllowedCharacters = CharacterSet(charactersIn: notAllowedCharacters)
            let characterSet = CharacterSet(charactersIn: string)
            if notAllowedCharacters.isSuperset(of: characterSet),
            !string.isEmpty { // Allow backspace
                return false
            }
        }

        // Max Length Validation
        if let maxLength = maxLength {
            if !isValidLength(textField: textField, range: range, string: string, maxLength: maxLength) {
                return false
            }
        }
        return delegate?.vfgTextFieldShouldChange(
            self,
            shouldChangeCharactersIn: range,
            replacementString: string
            ) ?? true
    }

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.vfgTextFieldShouldBeginEditing(textField) ?? true
    }

    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        delegate?.vfgTextFieldShouldEndEditing(textField) ?? true
    }

    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty ?? false {
            textFieldView?.textField.placeholder = self.secondaryPlaceholderText
        } else {
            textFieldView?.textField.placeholder = ""
        }
        delegate?.vfgTextFieldDidChangeSelection(textField)
    }

    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.vfgTextFieldShouldClear(textField) ?? false
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.vfgTextFieldShouldReturn(textField) ?? false
    }

    func isValidLength(
        textField: UITextField,
        range: NSRange,
        string: String,
        maxLength: Int
    ) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maxLength
    }

    func vfgTextFieldRightButtonClicked(_ textField: VFGGenericTextField) {
        delegate?.vfgTextFieldRightButtonClicked(self)
    }

    func vfgTextFieldTextChange(_ textField: VFGGenericTextField, text: String) {
        if isCountryTextField { return }
        textFieldView?.changeBorderState(to: .focus)
        if textFieldView?.counterView.isHidden == false {
            textFieldView?.updateCounterCurrentValue(textFieldText.count)
        }
        delegate?.vfgTextFieldDidChange(self, text: textFieldText)
    }
}
