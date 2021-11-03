//
//  VFGVerticalStepControlDataSource.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 5/9/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGVerticalStepControlDataSource: NSObjectProtocol {
    func numberOfSteps(_ stepControl: VFGVerticalStepControl) -> Int
    func stepEntry(_ stepControl: VFGVerticalStepControl, at index: Int) -> VFGStepViewEntry?
    func savedAction(_ stepControl: VFGVerticalStepControl, forStepAt index: Int) -> VFGStepAction?

    var enableTapAction: Bool { get }
}

extension VFGVerticalStepControlDataSource {
    public func savedAction(_ stepControl: VFGVerticalStepControl, forStepAt index: Int) -> VFGStepAction? {
        nil
    }

    public var enableTapAction: Bool {
        true
    }
}
