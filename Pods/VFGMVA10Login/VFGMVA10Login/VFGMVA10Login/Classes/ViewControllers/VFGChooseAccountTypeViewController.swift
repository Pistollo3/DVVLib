//
//  VFGChooseAccountTypeViewController.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 08/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

class VFGChooseAccountTypeViewController: UIViewController {
    @IBOutlet weak var mainTitleLabel: VFGLabel!
    @IBOutlet weak var mobileServiceLabel: VFGLabel!
    @IBOutlet weak var mobileServiceSubLabel: VFGLabel!
    @IBOutlet weak var mobileSeviceView: UIView!
    @IBOutlet weak var fixedLineServiceLabel: VFGLabel!
    @IBOutlet weak var fixedLineServiceSubLabel: VFGLabel!
    @IBOutlet weak var fixedLineServiceView: UIView!
    @IBOutlet weak var signInButton: VFGButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var signInButtonHightConstraint: NSLayoutConstraint!
    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    var buttonHeight: CGFloat = 43
    var isSignInButtonHidden = false {
        didSet {
            signInButton.isHidden = isSignInButtonHidden
            signInButtonHightConstraint.constant = isSignInButtonHidden ? 0 : buttonHeight
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocalization()
    }
    func setupLocalization() {
        mainTitleLabel.text = "choose_account_type_title".localized(bundle: .login)
        mobileServiceLabel.text = "choose_account_type_mobile_service_title".localized(bundle: .login)
        fixedLineServiceLabel.text = "choose_account_type_fixed_line_service".localized(bundle: .login)
        signInButton.setTitle("choose_account_type_sign_in_button_text".localized(bundle: .login), for: .normal)
    }
    @IBAction func fixedLineServiceButtonPressed(_ sender: VFGButton) {
        loginManagerNavigationDelegate?.navigateToFixedLine()
    }
    @IBAction func mobileServiceButtonPressed(_ sender: VFGButton) {
        loginManagerNavigationDelegate?.navigateToLoginEmail()
    }
    @IBAction func signInButtonPressed(_ sender: VFGButton) {
        loginManagerNavigationDelegate?.navigateToSavedAccounts()
    }
}
