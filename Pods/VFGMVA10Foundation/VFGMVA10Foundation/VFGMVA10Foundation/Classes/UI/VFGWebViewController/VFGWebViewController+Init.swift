//
//  VFGWebViewController+Init.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 9/3/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

extension VFGWebViewController {
    public class func instance(
        with viewModel: VFGWebViewModel,
        delegate: VFGWebViewDelegate? = nil
    ) -> VFGWebViewController {
        let webViewController = VFGWebViewController.instance(
            from: String("\(self)"),
            bundle: Bundle.foundation) as VFGWebViewController
        webViewController.delegate = delegate
        webViewController.viewModel = viewModel
        return webViewController
    }
}
