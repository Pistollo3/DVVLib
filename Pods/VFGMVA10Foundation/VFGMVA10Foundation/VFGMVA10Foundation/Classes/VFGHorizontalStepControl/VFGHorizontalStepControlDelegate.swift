//
//  VFGHorizontalStepControlDelegate.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGHorizontalStepControlDelegate: NSObjectProtocol {
    func stepControl(_ stepControl: VFGHorizontalStepControl, didCompleteStepAt index: Int)
    func stepControl(_ stepControl: VFGHorizontalStepControl, didReturnToStepAt index: Int)
    func stepControl(_ stepControl: VFGHorizontalStepControl, didSkipStepAt index: Int)
    func stepControl(_ stepControl: VFGHorizontalStepControl, didAddStepAt index: Int)
    func stepControl(_ stepControl: VFGHorizontalStepControl, didMoveToStepAt index: Int)
}

public extension VFGHorizontalStepControlDelegate {
    func stepControl(_ stepControl: VFGHorizontalStepControl, didSkipStepAt index: Int) { }
    func stepControl(_ stepControl: VFGHorizontalStepControl, didAddStepAt index: Int) { }
    func stepControl(_ stepControl: VFGHorizontalStepControl, didMoveToStepAt index: Int) { }
}
