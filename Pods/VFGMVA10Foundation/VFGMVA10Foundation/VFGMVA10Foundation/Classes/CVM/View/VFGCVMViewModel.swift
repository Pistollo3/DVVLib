//
//  VFGCVMViewModel.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed AbdElnabi on 30/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public struct VFGCVMViewModel {
    var title: String
    var description: String
    var buttonTitle: String
    var titleWhenDisabled: String

    weak var delegate: VFGCVMProtocol?

    public init(
        title: String,
        titleWhenDisabled: String = "",
        description: String,
        buttonTitle: String,
        delegate: VFGCVMProtocol? = nil
    ) {
        self.title = title
        self.titleWhenDisabled = titleWhenDisabled
        self.description = description
        self.buttonTitle = buttonTitle
        self.delegate = delegate
    }
}
