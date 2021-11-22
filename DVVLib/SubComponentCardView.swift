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
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] val in
                if val == .dashboard {
                    self?.topView.isHidden = false
                    self?.bottomView.isHidden = true
                } else {
                    self?.topView.isHidden = true
                    self?.bottomView.isHidden = false
                }
                self?.isUserInteractionEnabled = val == .dashboard
            }).disposed(by: disposeBag)
    }

}
