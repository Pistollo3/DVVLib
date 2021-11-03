//
//  ErrorCard.swift
//  VFGMVA10Foundation
//
//  Created by Hussein Kishk on 3/4/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public class ErrorCard: ErrorView {
    @IBOutlet var imageViewHeight: NSLayoutConstraint!
    @IBOutlet var tryAgainView: UIView!
    public var onTryAgain: (() -> Void)?

    public func setupImageHeight(height: CGFloat) {
        imageViewHeight.constant = height
    }

    public func hideTryAgainView() {
        tryAgainView.isHidden = true
    }

    public func showTryAgainView() {
        tryAgainView.isHidden = false
    }

    @IBAction func tryAgain(_ sender: VFGButton) {
        onTryAgain?()
    }
}
