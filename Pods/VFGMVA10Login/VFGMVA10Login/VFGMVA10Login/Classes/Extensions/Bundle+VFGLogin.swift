//
//  Bundle+VFGLogin.swift
//  VFGLogin
//
//  Created by Mohamed Abd ElNasser on 7/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension Bundle {
    public class var login: Bundle {
        // To be changed when an entry view controller is created for the component
        return Bundle(for: VFGLoginEmail.self)
    }
}
