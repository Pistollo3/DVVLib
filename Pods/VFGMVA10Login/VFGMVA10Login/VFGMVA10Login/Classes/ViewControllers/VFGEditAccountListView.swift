//
//  VFGEditAccountListView.swift
//  VFGMVA10Login
//
//  Created by Essam Orabi on 18/05/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit
import VFGMVA10Foundation

protocol VFGEditAccountListDelegate: AnyObject {
    func deleteButtonDidPress(selectedAccount: VFGAccount)
    func cancelButtonDidPress()
}

class VFGEditAccountListView: UIView {
    @IBOutlet weak var accountsTableView: UITableView!
    @IBOutlet weak var returnToSignInButton: VFGButton!
    @IBOutlet weak var mainTitleLabel: VFGLabel!
    @IBOutlet weak var descriptionLabel: VFGLabel!

    let accountCellName = "VFGEditAccountListCell"
    weak var delegate: VFGEditAccountListDelegate?
    weak var accountsListDelegate: VFGLoginAccountsListProtocol? {
        didSet {
            getSavedAccounts()
        }
    }
    var savedAccounts: [VFGAccountItemCellViewModel] = [] {
        didSet {
            accountsTableView.reloadData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        registerAccountCell()
        setupDataLabels()
    }

    func registerAccountCell() {
        let nibName = UINib(nibName: accountCellName, bundle: Bundle.login)
        accountsTableView.register(nibName, forCellReuseIdentifier: accountCellName)
        accountsTableView.delegate = self
        accountsTableView.dataSource = self
        accountsTableView.tableFooterView = UIView()
    }

    func setupDataLabels() {
        mainTitleLabel.text = "registered_account_edit_your_account_list_label".localized(bundle: .login)
        descriptionLabel.text = "registered_account_edit_dialog_hint".localized(bundle: .login)
        returnToSignInButton.setTitle("registered_account_edit_dialog_button".localized(bundle: .login), for: .normal)
    }

    func getSavedAccounts() {
        savedAccounts = accountsListDelegate?.retrieveSavedAccounts().map { VFGAccountItemCellViewModel(account: $0) }
            ?? []
    }

    func deleteButtonDidPress(index: IndexPath) {
        let accountViewModel = savedAccounts[index.row]
        delegate?.deleteButtonDidPress(selectedAccount: accountViewModel.account)
    }

    @IBAction func returnToSignInButtonDidPress(_ sender: VFGButton) {
        delegate?.cancelButtonDidPress()
    }
}

extension VFGEditAccountListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedAccounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: accountCellName,
            for: indexPath) as? VFGEditAccountListCell else { return UITableViewCell() }
        cell.deleteButtonDidPress = {[weak self] _ in
            guard let self = self else { return }
            self.deleteButtonDidPress(index: indexPath)
        }
        cell.configWith(savedAccounts[indexPath.row])
        return cell
    }
}
