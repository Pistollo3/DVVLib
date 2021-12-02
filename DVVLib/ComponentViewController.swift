//
//  ComponentViewController.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 08/11/21.
//

import UIKit
import RxSwift

class ComponentViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.label.isHidden = value == .onboarding
                self?.btn.isHidden = value == .dashboard
            }).disposed(by: disposeBag)
        

        // Do any additional setup after loading the view.
    }


    @IBAction private func makeRequest() {
        GHSuperWifiManager.shared.startOnboarding()
        GHLocalizationManager.setupContentDictionary()
    }

}
