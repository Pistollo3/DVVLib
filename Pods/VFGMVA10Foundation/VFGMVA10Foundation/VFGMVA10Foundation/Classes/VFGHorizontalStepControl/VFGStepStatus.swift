//
//  VFGStepStatus.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 8/27/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public enum VFGStepStatus: String, Codable {
    case inProgress = "selected"
    case pending
    case passed = "finished"
    case skipped
}
