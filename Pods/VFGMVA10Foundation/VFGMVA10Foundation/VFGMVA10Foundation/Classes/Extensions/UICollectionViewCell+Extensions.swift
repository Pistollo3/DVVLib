//
//  UICollectionViewCell+Extensions.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 20/08/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

public extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
