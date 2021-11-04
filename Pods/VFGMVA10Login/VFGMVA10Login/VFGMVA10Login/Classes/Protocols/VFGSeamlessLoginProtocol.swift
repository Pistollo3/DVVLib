//
//  VFGSeamlessLoginProtocol.swift
//  VFGLogin
//
//  Created by Hussien Gamal Mohammed on 7/28/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGMVA10Foundation
/**
Allows user to login automatically if using a Vodafone Sim Card.
- seamlessAPIImplementation: Logic to be implemented for seamless flow.
- tobiDelegate: delegate that handles Tobi animation.
*/
public protocol VFGSeamlessLoginProtocol: AnyObject {
    func seamlessAPIImplementation(completion: ((VFGLoginResult) -> Void))
    func moreInformationViewController() -> UIViewController?
    func presentChangeLanguageViewController()
    var tobiDelegate: VFGTobiHandlerDelegate? { get set }
}

protocol VFGSeamlessInternalProtocol: AnyObject {
    func seamlessCompletion(result: VFGLoginResult)
}

extension VFGSeamlessLoginProtocol {
    public func moreInformationViewController() -> UIViewController? { nil }
    public func presentChangeLanguageViewController() {}
}
