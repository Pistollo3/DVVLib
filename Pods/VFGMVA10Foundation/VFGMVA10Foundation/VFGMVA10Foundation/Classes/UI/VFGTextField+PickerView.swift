//
//  VFGTextField+PickerView.swift
//  VFGMVA10Foundation
//
//  Created by Hamsa Hassan on 1/4/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

extension VFGTextField {
    public func configureCountries(
        topTitleText: String? = nil,
        placeHolder: String? = nil,
        pickerViewDoneTitle: String,
        pickerViewCancelTitle: String,
        countries: [String]? = nil
    ) {
        isCountryTextField = true
        textFieldTopTitleText = topTitleText
        textFieldPlaceHolderText = placeHolder
        self.countries = countries ?? allCountries()

        textFieldView?.rightButton.isUserInteractionEnabled = false
        textFieldView?.textField.tintColor = .clear
        textFieldRightIcon = UIImage(named: "icChevronDown", in: .foundation)

        setupCountryTextField(
            pickerViewDoneTitle: pickerViewDoneTitle,
            pickerViewCancelTitle: pickerViewCancelTitle
        )
    }

    @objc func setupCountryTextField(
        pickerViewDoneTitle: String,
        pickerViewCancelTitle: String
        ) {
        pickerView = UIPickerView()
        toolBar = UIToolbar()
        guard let pickerView = pickerView,
            let toolBar = toolBar else { return }

        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .VFGWhiteBackground

        // ToolBar initialization
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .VFGPrimaryText
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            title: pickerViewDoneTitle,
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(doneButtonTapped)
        )
        let spaceButton = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil
        )
        let cancelButton = UIBarButtonItem(
            title: pickerViewCancelTitle,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        textFieldView?.textField.inputView = pickerView
        textFieldView?.textField.inputAccessoryView = toolBar
    }

    @objc func doneButtonTapped() {
        guard let selectedRow = pickerView?.selectedRow(inComponent: 0) else {
            cancelButtonTapped()
            return
        }
        textFieldView?.textField.resignFirstResponder()
        if !countries.isEmpty,
            0..<countries.count ~= selectedRow {
            textFieldText = countries[selectedRow]
        }
    }

    @objc func cancelButtonTapped() {
        textFieldView?.textField.resignFirstResponder()
    }

    func allCountries() -> [String] {
        Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0) }.sorted()
    }
}
