//
//  ComponentViewController.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 08/11/21.
//

import UIKit

class ComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction private func makeRequest() {
        GHGoogleManager.shared.makeRequest()
    }

}
