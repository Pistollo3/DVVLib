//
//  LanguageQuickActionModel.swift
//  VFGMVA10Group
//
//  Created by Ashraf Dewan on 02/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import VFGMVA10Foundation

public class LanguageQuickActionModel: VFQuickActionsModel {
    weak var delegate: VFQuickActionsProtocol?
    let languages: [LanguageModel]
    public var onLanguageChange: ((LanguageModel) -> Void)?
    var selectedLanguage: LanguageModel?

    public init(languages: [LanguageModel]) {
        self.languages = languages
    }

    public var quickActionsTitle: String {
        return "change_language_modal_title".localized(bundle: .login)
    }

    public var quickActionsStyle: VFQuickActionsStyle {
        return .white
    }

    public var quickActionsContentView: UIView {
        guard let languageView: VFGLanguageView = UIView.loadXib(bundle: .login) else {
            return UIView()
        }

        languageView.onConfirmButtonPress = { [weak self] language in
            self?.selectedLanguage = language
            self?.closeQuickAction()
        }
        languageView.configure(languages: languages)
        return languageView
    }

    public func quickActionsProtocol(delegate: VFQuickActionsProtocol) {
        self.delegate = delegate
    }

    public func closeQuickAction() {
        delegate?.closeQuickAction { [weak self] in
            guard let selectedLanguage = self?.selectedLanguage else {
                return
            }
            self?.onLanguageChange?(selectedLanguage)
        }
    }
}
