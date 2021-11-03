//
//  VFGLoginManagerDelegate.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/28/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

/**
VFGLoginManagerDelegate.
- present: Implementation for presenting login view controller in the app.
- onFinish: Implementation for finishing login either with success or failure.
*/
public protocol VFGLoginManagerDelegate: class {
    func present(viewController: UIViewController)
    func onFinish(result: VFGLoginResult, dismiss viewController: UIViewController?)
}
