//
//  Optional+Default.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

extension Int: DefaultValue {
    public static var defaultValue: Int { return 0 }
}

extension Double: DefaultValue {
    public static var defaultValue: Double { return 0.0 }
}

extension Float: DefaultValue {
    public static var defaultValue: Float { return 0.0 }
}

extension String: DefaultValue {
    public static var defaultValue: String { return "" }
}

extension Bool: DefaultValue {
    public static var defaultValue: Bool { return false }
}

extension Array: DefaultValue {
    public static var defaultValue: [Element] { return [] }
}

extension UITableViewCell: DefaultValue {
    public static var defaultValue: UITableViewCell { return UITableViewCell(frame: .zero) }
}
