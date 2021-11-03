//
//  UITextView+RTLHandling.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 07/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if UIView.appearance().semanticContentAttribute == .forceRightToLeft, textAlignment != .center {
            textAlignment = .right
        }
    }
}
