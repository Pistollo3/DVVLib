//
//  SubComponentEntry.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import VFGMVA10Foundation
import RxSwift

public class SubComponentEntry: NSObject, VFGComponentEntry {
    public var cardEntryViewController: UIViewController? {
        let bundle = Bundle(for: self.classForCoder)
        return ComponentViewController(nibName: "ComponentViewController", bundle: bundle)
    }
    public var cardView: UIView?
    
    var disposeBag = DisposeBag()
    
    required public init(config: [String : Any]?, error: [String : Any]?) {
        super.init()
        GHSuperWifiManager.shared.subscribeToOnboarding()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] value in
                guard let self = self else { return }
                let bundle = Bundle(for: self.classForCoder)
            
                self.cardView = value == .onboarding ? nil : bundle.loadNibNamed("ComponentCardView", owner: self, options: nil)?.first as? UIView
            }).disposed(by: disposeBag)
    }
    
    required init(config: [String : Any]?) {
    }
}
