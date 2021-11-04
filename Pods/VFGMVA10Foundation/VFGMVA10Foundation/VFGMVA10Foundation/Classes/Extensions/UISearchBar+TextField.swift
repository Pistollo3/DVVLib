//
//  UISearchBar+TextField.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

public extension UISearchBar {
    var textField: UITextField? {
        return self.value(forKey: "searchField") as? UITextField
    }
}
