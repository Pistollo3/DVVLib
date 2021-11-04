//
//  VFGStepViewEntry.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Mahmoud Zaki on 6/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import UIKit

public protocol VFGStepViewEntry: class {
    var stepEntryDelegate: VFGStepViewEntryDelegate? { get set }
    var title: String? { get set }
    var stepView: UIView { get }
    var data: [String: Any]? { get set }
    var sideView: UIView? { get set }
    init(config: [String: Any]?)
}

extension VFGStepViewEntry {
    public var data: [String: Any]? { nil }
    public var sideView: UIView? { nil }
}

public protocol VFGStepViewEntryDelegate: class {
    func stepEntry(_ stepEntry: VFGStepViewEntry?, action: VFGStepAction, data: [String: Any]?)
}
