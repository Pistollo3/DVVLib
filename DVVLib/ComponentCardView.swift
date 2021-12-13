//
//  ComponentCardView.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import UIKit
import RxSwift

class ComponentCardView: UIView {
    @IBOutlet weak var label: UILabel!
    
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.label.text = "custom_dialog_cancel".localized
            }).disposed(by: disposeBag)
    }

}
