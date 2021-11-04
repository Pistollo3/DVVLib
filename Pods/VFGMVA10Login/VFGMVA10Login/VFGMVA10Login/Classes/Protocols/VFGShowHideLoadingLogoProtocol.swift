//
//  VFGShowHideLoadingLogoProtocol.swift
//  VFGLogin
//
//  Created by Hussein Kishk on 21/12/2020.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

/**
Show and Hide loading animation logo.
- show: Show logo animation with text.
- hide: Hide logo animation with success state.
*/
protocol VFGShowHideLoadingLogoProtocol: class {
    func show(with text: String?)
    func hide(with success: Bool)
}
