//
//  VFGGenericTextFieldProtocol.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed on 8/7/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
internal protocol VFGGenericTextFieldProtocol: class {
    /// Tells the delegate when the right button icon in the specified `VFGGenericTextField` clicked.
    /// - Parameters:
    ///   - textField: The `VFGGenericTextField` containing the icon
    func vfgTextFieldRightButtonClicked(_ textField: VFGGenericTextField)

    /// Tells the delegate when change happend in the specified `VFGGenericTextField`.
    /// - Parameters:
    ///   - textField: The `VFGGenericTextField` containing the text
    func vfgTextFieldTextChange(_ textField: VFGGenericTextField, text: String)

    /// `VFGGenericTextField` view background color
    var customBackgroundColor: UIColor? { get }
}
