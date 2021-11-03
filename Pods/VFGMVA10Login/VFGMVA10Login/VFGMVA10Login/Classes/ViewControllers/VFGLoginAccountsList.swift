//
//  VFGLoginAccountsList.swift
//  VFGMVA10Login
//
//  Created by Hussien Gamal Mohammed Fahmy on 11/04/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

class VFGLoginAccountsList: UIViewController {
    // MARK: Properties
    static let storyBoardName = "VFGLoginAccountsList"
    weak var loginManagerNavigationDelegate: VFGLoginManagerNavigationProtocol?
    weak var loadingDelegate: VFGShowHideLoadingLogoProtocol?
    weak var editAccountDelegate: VFGEditAccountListStateInternalProtocol?
    weak var delegate: VFGEditAccountListStateManager?
    var editAccountStateManager: VFGEditAccountListStateManager?
    var itemsViewModels: [VFGAccountItemCellViewModel] = [] {
        didSet {
            if tableView.contentSize.height >= UIScreen.main.bounds.height * 0.3 {
                tableViewHeightConstraint.constant = UIScreen.main.bounds.height * 0.3
                tableViewHeightConstraint.priority = .defaultHigh
            } else {
                tableViewHeightConstraint.constant = 0
                tableViewHeightConstraint.priority = .defaultLow
            }
            tableView.invalidateIntrinsicContentSize()
            tableView.reloadData()
        }
    }
    weak var accountsListDelegate: VFGLoginAccountsListProtocol?

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountsCountLabel: VFGLabel!
    @IBOutlet weak var editAccountsListButton: VFGButton!
    @IBOutlet weak var signWithAnotherAccountButton: VFGButton!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!

    // MARK: Actions
    @IBAction func editAccountsListClicked(_ sender: Any) {
        editAccountStateManager = VFGEditAccountListStateManager(with: accountsListDelegate)
        editAccountStateManager?.loginManagerNavigationDelegate = loginManagerNavigationDelegate
        editAccountStateManager?.setup()
        VFGLoginManager.trackView(screenType: .editAccountsList)
    }

    @IBAction func signWithAnotherAccountClicked(_ sender: Any) {
        loginManagerNavigationDelegate?.navigateToChooseAccount()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configEditButtonStyle()
        configSignToAnotherAccountButton()
        configTableView()
        configViewModels()
        configAccountsCountLabel()
    }

    // MARK: UI configuration & localization
    func configEditButtonStyle() {
        let editButtonTitle = "registered_account_edit_your_account_list_label".localized(bundle: Bundle.login)
        editAccountsListButton.setUnderlinedTitle(
            title: editButtonTitle,
            font: .vodafoneRegular(14),
            color: .VFGSecondaryText,
            state: .normal)
    }

    func configSignToAnotherAccountButton() {
        signWithAnotherAccountButton.setTitle(
            "registered_account_sign_in_another_account_button".localized(bundle:
            Bundle.login),
            for: .normal
        )
    }

    func configAccountsCountLabel() {
        let localizedCountsLabelText = "registered_account_your_accounts_label".localized(bundle: Bundle.login)
        let count = itemsViewModels.count
        let formattedCount = String(format: localizedCountsLabelText, "\(count)")
        accountsCountLabel.font = UIFont.vodafoneLite(25)
        accountsCountLabel.text = formattedCount
    }

    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func configViewModels() {
        itemsViewModels = accountsListDelegate?.retrieveSavedAccounts().map { VFGAccountItemCellViewModel(account: $0) }
            ?? []
    }
}

// MARK: tableview delegate and datasource
extension VFGLoginAccountsList: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let emptyView = UIView()
        emptyView.frame = CGRect.zero
        return emptyView
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsViewModels.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let accountItem = itemsViewModels[indexPath.row].account
        accountsListDelegate?.didSelect(accountItem, at: indexPath.row)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = String(describing: VFGAccountItemCell.self)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellID,
            for: indexPath) as? VFGAccountItemCell else {
            return UITableViewCell()
        }
        cell.configWith(itemsViewModels[indexPath.row])
        return cell
    }
}

extension UITableView {
    open override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
