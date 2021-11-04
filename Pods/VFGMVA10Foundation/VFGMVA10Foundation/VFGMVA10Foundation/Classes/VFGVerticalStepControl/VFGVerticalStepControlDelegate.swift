//
//  VFGVerticalStepControlDelegate.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 5/10/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGVerticalStepControlDelegate: NSObjectProtocol {
    func stepControl(_ stepControl: VFGVerticalStepControl, didCompleteStepAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, didReturnToStepAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, didSkipStepAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, didPressOnLinkAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, didMoveToStepAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, willMoveFromStepAt index: Int)
    func stepControl(_ stepControl: VFGVerticalStepControl, didSelectStepAt index: Int)
}

public extension VFGVerticalStepControlDelegate {
    func stepControl(_ stepControl: VFGVerticalStepControl, didCompleteStepAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, didReturnToStepAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, didSkipStepAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, didPressOnLinkAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, didMoveToStepAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, willMoveFromStepAt index: Int) {}
    func stepControl(_ stepControl: VFGVerticalStepControl, didSelectStepAt index: Int) {}
}
