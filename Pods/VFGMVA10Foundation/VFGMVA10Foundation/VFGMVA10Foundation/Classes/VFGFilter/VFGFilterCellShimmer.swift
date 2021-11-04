//
//  VFGFilterCellShimmer.swift
//  VFGMVA10Foundation
//
//  Created by Hussien Gamal Mohammed on 18/11/2020.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

class VFGFilterCellShimmer: UICollectionViewCell {
    @IBOutlet var shimmerdView: VFGShimmerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        roundCorners(cornerRadius: 17)
    }
    func startShimmer() {
        shimmerdView.startAnimation()
    }
    func stopShimmer() {
        removeFromSuperview()
    }
}
