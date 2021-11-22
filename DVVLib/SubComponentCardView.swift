//
//  SubComponentCardView.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import UIKit
import RxSwift

class SubComponentCardView: UIView {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topView: UIView!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] val in
                self?.label.text = val == .dashboard ? "Super WiFi" : "You need to perform onboarding first!"
                self?.isUserInteractionEnabled = val == .dashboard
            }).disposed(by: disposeBag)
    }

}
