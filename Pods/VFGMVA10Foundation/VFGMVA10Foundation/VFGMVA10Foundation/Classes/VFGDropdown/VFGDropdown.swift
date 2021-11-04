//
//  VFGDropdown.swift
//  VFGMVA10Foundation
//
//  Created by Fafoutis, Athinodoros, Vodafone Greece on 25/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGDropdownDelegate: AnyObject {
    func didSelect(selectedItem: VFGOverflowMenuItem, index: Int)
    // Optional
    func willOpen()
    func didOpen()
    func willClose()
    func didClose()
}

public extension VFGDropdownDelegate {
    func willOpen() {}
    func didOpen() {}
    func willClose() {}
    func didClose() {}
}

/// VFGDropdown is an overflow menu that is placed under a VFGTextField and can be added both though code and UI
public class VFGDropdown: VFGTextField {
    public weak var dropdownDelegate: VFGDropdownDelegate?
    var overflowMenu: VFGOverflowMenu

    @IBInspectable var hideOptionsWhenSelect: Bool = true
    @IBInspectable var supportFreeText: Bool = false
    @IBInspectable var rowEstimatedHeight: CGFloat = 48
    @IBInspectable var maxTableHeight: CGFloat = 150


    /// VFGDropdown is an overflow menu that is placed under a VFGTextField
    /// - Parameters:
    ///   - topTitleText: VFGTextField's top title text
    ///   - placeHolder: VFGTextField's placeholder text
    ///   - tipText: VFGTextField's tip text
    ///   - rowEstimatedHeight: The estimated row height
    ///   - maxTableHeight: The maximum height of the OverflowMenu. If the height is lower than this number then the height is calculated automatically
    ///   - hideOptionsWhenSelect: If true, closes the OverflowMenu when an item is selected
    ///   - supportFreeText: If true, user can write directly within the textfield, otherwise the user cannot write in textfield and the text is updated only by selecting an element from overflow menu
    ///   - items: A list with VFGOverflowMenuItem that will be shown within the OverflowMenu
    public init(
        topTitleText: String? = nil,
        placeHolder: String? = nil,
        tipText: String? = nil,
        rowEstimatedHeight: CGFloat = 50,
        maxTableHeight: CGFloat = 150,
        hideOptionsWhenSelect: Bool = true,
        supportFreeText: Bool = false,
        items: [VFGOverflowMenuItem] = [],
        parentViewController: UIViewController? = nil
    ) {
        self.hideOptionsWhenSelect = hideOptionsWhenSelect
        self.supportFreeText = supportFreeText
        self.rowEstimatedHeight = rowEstimatedHeight
        self.maxTableHeight = maxTableHeight
        overflowMenu = VFGOverflowMenu(triggerView: UIView(), baseView: UIView(), overflowMenuDatasource: [])
        super.init(frame: .zero)
        customUI()
        configure(
            topTitleText: topTitleText,
            placeHolder: placeHolder,
            tipText: tipText,
            items: items,
            parentViewController: parentViewController
        )
    }

    /// When initialising the VFGDropdown through UI, you should call the configure method in order to set its data and frame
    @objc public required init?(coder aDecoder: NSCoder) {
        self.overflowMenu = VFGOverflowMenu(triggerView: UIView(), baseView: UIView(), overflowMenuDatasource: [])
        super.init(coder: aDecoder)
        customUI()
    }

    override func customUI() {
        super.customUI()
        delegate = self
        resetTextField()
        textFieldRightIcon = nil
    }


    /// VFGDropdown is an overflow menu that is placed under a VFGTextField. When added through UI this method must be called in order to configure its values
    /// - Parameters:
    ///   - topTitleText: VFGTextField's top title text
    ///   - placeHolder: VFGTextField's placeholder text
    ///   - tipText: VFGTextField's tip text
    ///   - items: A list with VFGOverflowMenuItem that will be shown within the OverflowMenu
    public func configure(
        topTitleText: String? = nil,
        placeHolder: String? = nil,
        tipText: String? = nil,
        items: [VFGOverflowMenuItem],
        parentViewController: UIViewController? = nil
    ) {
        configureTextField(
            topTitleText: topTitleText ?? textFieldTopTitleText,
            placeHolder: placeHolder ?? textFieldPlaceHolderText,
            rightIcon: UIImage(named: "icChevronDown", in: .foundation),
            tipText: tipText
        )

        // remove the tipHeight in order to eliminate the space between the textfield and the overflow menu
        if tipText == nil {
            textFieldView?.errorHintLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }

        overflowMenu = VFGOverflowMenu(
            triggerView: self,
            baseView: parentViewController?.view ?? self.parentViewController?.view,
            overflowMenuDatasource: items,
            rowEstimatedHeight: rowEstimatedHeight,
            maxTableHeight: maxTableHeight,
            hideOptionsWhenSelect: hideOptionsWhenSelect)
        overflowMenu.overflowMenuDelegate = self
    }

    public func closeOverflowMenu() {
        overflowMenu.close()
    }

    private var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension VFGDropdown: VFGTextFieldProtocol {
    public func vfgTextFieldDidBeginEditing(_ vfgTextField: VFGTextField) {
        overflowMenu.open()
    }

    public func vfgTextFieldDidEndEditing(_ vfgTextField: VFGTextField) {
        overflowMenu.close()
    }

    public func vfgTextFieldRightButtonClicked(_ vfgTextField: VFGTextField) {
        overflowMenu.toggle()
        let selectedIndex = overflowMenu.overflowMenuDatasource.firstIndex { $0.primaryText == textFieldText }
        overflowMenu.selectedIndex = selectedIndex
        textFieldView?.changeBorderColor(to: overflowMenu.isOpened ? .focus : .normal)
    }

    public func vfgTextFieldShouldChange(
        _ vfgTextField: VFGTextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        if let textFieldText = vfgTextField.textFieldText as NSString? {
            let primaryText = textFieldText.replacingCharacters(in: range, with: string)
            return supportFreeText || overflowMenu.containsOption(with: primaryText)
        }
        return supportFreeText
    }

    public func vfgTextFieldDidChange(_ vfgTextField: VFGTextField, text: String) {
        overflowMenu.updateDataSource(text: text)
    }
}

extension VFGDropdown: VFGOverflowMenuDelegate {
    public func didSelect(selectedItem: VFGOverflowMenuItem, index: Int) {
        textFieldText = "\(selectedItem.primaryText)"
        dropdownDelegate?.didSelect(selectedItem: selectedItem, index: index)
    }

    public func willOpen() {
        UIView.animate(withDuration: 0.25) {
            self.textFieldView?.rightButton.transform = CGAffineTransform(rotationAngle: .pi)
            self.layoutIfNeeded()
        }
        dropdownDelegate?.willOpen()
    }

    public func didOpen() {
        dropdownDelegate?.didOpen()
    }

    public func willClose() {
        UIView.animate(withDuration: 0.25) {
            self.textFieldView?.rightButton.transform = CGAffineTransform.identity
            self.textFieldView?.changeBorderColor(to: .normal)
            self.layoutIfNeeded()
        }
        dropdownDelegate?.willClose()
    }

    public func didClose() {
        endEditing(true)
        if !textFieldText.isEmpty {
            textFieldView?.changeBorderState(to: .full)
        }
        dropdownDelegate?.didClose()
    }
}
