//
//  VFGHorizontalStepControlDataSource.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 8/27/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGHorizontalStepControlDataSource: NSObjectProtocol {
    var isInteractionEnabled: Bool { get }
    func numberOfSteps(_ stepControl: VFGHorizontalStepControl) -> Int
    func title(_ stepControl: VFGHorizontalStepControl, forStepAt index: Int) -> String
    func status(_ stepControl: VFGHorizontalStepControl, forStepAt index: Int) -> VFGStepStatus
    func stepsDataURL(_ stepControl: VFGHorizontalStepControl) -> URL?
}

public extension VFGHorizontalStepControlDataSource {
    var isInteractionEnabled: Bool { true }
    func stepsDataURL(_ stepControl: VFGHorizontalStepControl) -> URL? {
        nil
    }

    func status(_ stepControl: VFGHorizontalStepControl, forStepAt index: Int) -> VFGStepStatus {
        .pending
    }
}
