//
//  VFQuickActionsModel.swift
//  VFGMVA10Foundation
//
//  Created by Sandra Morcos on 7/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public enum VFQuickActionsStyle {
    case red, white
}

public protocol VFQuickActionsModel {
    /// used to pass the quick actions delegate
    func quickActionsProtocol(delegate: VFQuickActionsProtocol)
    /// to close quick action
    func closeQuickAction()
    /// to go back to the previous state
    func backQuickAction()
    /// fired after clicking on the header button
    func headerButtonAction()
    /// style enum to specify the background of the view, default is red
    var quickActionsStyle: VFQuickActionsStyle { get }
    /// a view that is being presented
    var quickActionsContentView: UIView { get }
    /// quick action title
    var quickActionsTitle: String { get }
    /// header button title, default is empty string
    /// - note: make sure that isHeaderButtonHidden is set to false
    var headerButtonTitle: String { get }
    var accessibilityModel: VFQuickActionsAccessibilityModel { get }
    /// a boolean to check whether user interaction is enabled or not
    var isUserInteractionEnabled: Bool { get }
    /// a boolean to show or hide back button, default is true
    var isBackButtonHidden: Bool { get }
    /// a boolean to show or hide close button, default is false
    var isCloseButtonHidden: Bool { get }
    /// close button image
    var closeButtonImage: UIImage? { get }
    /// a boolean to show or hide header button, default is true
    var isHeaderButtonHidden: Bool { get }
    /// a boolean to raise the view up and show the keyboard
    var shouldRaiseForKeyboard: Bool { get }
    /// a property to change the font of the header title
    var titleFont: UIFont { get }
}

extension VFQuickActionsModel {
    public var quickActionsStyle: VFQuickActionsStyle {
        return .red
    }

    public var isBackButtonHidden: Bool {
        true
    }

    public func backQuickAction() {}

    public func headerButtonAction() {}

    public var isCloseButtonHidden: Bool {
        return false
    }

    public var closeButtonImage: UIImage? {
        return VFGImage(named: "icClose")
    }

    public var isHeaderButtonHidden: Bool {
        true
    }

    public var headerButtonTitle: String {
        ""
    }

    public var isUserInteractionEnabled: Bool {
        false
    }

    public var accessibilityModel: VFQuickActionsAccessibilityModel {
        VFQuickActionsAccessibilityModel()
    }

    public var shouldRaiseForKeyboard: Bool { false }

    public var titleFont: UIFont { UIFont.vodafoneBold(17) }
}
