//
//  VFGLanguageView.swift
//  VFGMVA10Login
//
//  Created by Ashraf Dewan on 01/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

public class VFGLanguageView: UIView {
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: VFGLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: VFGButton!

    // MARK: - Properties
    var onConfirmButtonPress: ((LanguageModel?) -> Void)?
    var languages: [LanguageModel]?
    lazy var currentLanguageIndex: Int? = {
        languages?.firstIndex { $0.isCurrentLanguage == true }
    }()

    // MARK: - Overrides
    public override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
        registerCell()
    }

    // MARK: - Public Methods
    public func configure(languages: [LanguageModel]) {
        self.languages = languages

        tableView.reloadData()
    }

    // MARK: - Private Methods
    func setupUI() {
        titleLabel.text = "change_language_modal_subtitle".localized(bundle: .login)
        confirmButton.setTitle(
            "change_language_modal_button".localized(bundle: .login),
            for: .normal)
    }

    func registerCell() {
        tableView.register(
            UINib(
                nibName: String(describing: VFGRadioCell.self),
                bundle: .foundation),
            forCellReuseIdentifier: String(describing: VFGRadioCell.self))
    }

    func radioButtonDidPress(at indexPath: IndexPath, tableView: UITableView) {
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        currentLanguageIndex = indexPath.row
    }

    // MARK: - Actions
    @IBAction func confirmButtonDidPress() {
        guard let index = currentLanguageIndex, let language = languages?[index] else { return }
        onConfirmButtonPress?(language.isCurrentLanguage == true ? nil : language)
    }
}

extension VFGLanguageView: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languages?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let radioCell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: VFGRadioCell.self),
                for: indexPath) as? VFGRadioCell else {
            return UITableViewCell()
        }
        guard let model = languages?[indexPath.row] else {
            return UITableViewCell()
        }

        let isFirst = indexPath.row == 0 ? true : false
        let isLast = indexPath.row == languages?.count ? true : false

        radioCell.configure(
            title: model.name,
            imageName: model.imageName,
            isFirstCell: isFirst,
            isLastCell: isLast
        )

        radioCell.selectionStyle = .none
        radioCell.contentView.backgroundColor = .VFGWhiteBackground

        radioCell.onRadioButtonPress = { [weak self] in
            self?.radioButtonDidPress(at: indexPath, tableView: tableView)
        }

        return radioCell
    }

    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if languages?[indexPath.row].isCurrentLanguage == true {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }

    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        currentLanguageIndex = indexPath.row
    }
}
