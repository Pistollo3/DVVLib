//
//  DemoComponentEntry.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 08/11/21.
//
import VFGMVA10Foundation

public class DemoComponentEntry: NSObject, VFGComponentEntry {
    required public init(config: [String : Any]?, error: [String : Any]?) {
        print("ok")
    }
    
    required init(config: [String : Any]?) {
    }

    public var cardView: UIView? {
        let bundle = Bundle(for: self.classForCoder)
        return bundle.loadNibNamed("ComponentCardView", owner: self, options: nil)?.first as? UIView
    }

    public var cardEntryViewController: UIViewController? {
        let bundle = Bundle(for: self.classForCoder)
        return ComponentViewController(nibName: "ComponentViewController", bundle: bundle)
    }
}
