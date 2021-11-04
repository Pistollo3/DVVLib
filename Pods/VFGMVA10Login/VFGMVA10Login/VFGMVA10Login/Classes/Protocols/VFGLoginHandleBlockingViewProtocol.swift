//
//  VFGLoginHandleBlockingViewProtocol.swift
//  VFGLogin
//
//  Created by Esraa Eldaltony on 10/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

/**
Blocking view.
- addBlockingView: Add blocking view with username.
- removeBlockingView: Removes blocking view.
*/
protocol VFGLoginHandleBlockingViewProtocol: class {
    func addBlockingView(userEmail: String)
    func removeBlockingView()
}
