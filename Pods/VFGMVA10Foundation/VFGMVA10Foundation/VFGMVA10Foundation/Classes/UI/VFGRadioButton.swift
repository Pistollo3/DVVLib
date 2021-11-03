//
//  VFGRadioButton.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed on 4/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGRadioButton: VFGButton {
    let activeImage = VFGImage(named: "VFGRadioButtonActive")
    let inactiveImage = VFGImage(named: "VFGRadioButtonInactive")

    override public var isSelected: Bool {
        didSet {
            setImage(isSelected ? activeImage : inactiveImage, for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUI()
    }

    func customUI() {
        setTitle("", for: .normal)
        buttonStyle = ButtonStyle.icon.rawValue
        isSelected = false
    }
}
