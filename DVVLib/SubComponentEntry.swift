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
        return SubComponentViewController(nibName: "SubComponentViewController", bundle: bundle)
    }
    public var cardView: UIView? {
        let bundle = Bundle(for: self.classForCoder)
        return bundle.loadNibNamed("SubComponentCardView", owner: self, options: nil)?.first as? UIView
    }
    
    var disposeBag = DisposeBag()
    
    required public init(config: [String : Any]?, error: [String : Any]?) {
    }
    
    required init(config: [String : Any]?) {
    }
}
