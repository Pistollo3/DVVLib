//
//  SubComponentCardView.swift
//  DVVLib
//
//  Created by Daniele Viscuso on 22/11/21.
//

import UIKit

class SubComponentCardView: UIView {
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.text = "Super Wifi!"
    }

}
