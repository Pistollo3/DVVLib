//
//  UIView+LoadFromNib.swift
//  VFGMVA10Malta
//
//  Created by Mohamed Abd ElNasser on 6/25/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {
    @discardableResult
    public func loadViewFromNib(nibName: String, in bundle: Bundle? = nil) -> UIView? {
        let nib = UINib(nibName: nibName, bundle: bundle ?? Bundle(for: type(of: self)))
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }

    public func xibSetup(contentView: UIView) {
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
