//
//  ComponentCardView.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import UIKit
import RxSwift

class ComponentCardView: UIView {
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.isHidden = value == .dashboard
            }).disposed(by: disposeBag)
    }

}
