//
//  VFGTutorialMarginsModel.swift
//  VFGMVA10Foundation
//
//  Created by Mohamed Abd ElNasser on 6/7/21.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public struct VFGTutorialMarginsModel {
    var uiContentHeight: CGFloat
    var uiContentToTitle: CGFloat
    var titleToSubTitle: CGFloat
    var subTitleToIndicator: CGFloat?
    var indicatorToButton: CGFloat

    public init(
        uiContentHeight: CGFloat = UIScreen.main.bounds.height * 0.45,
        uiContentToTitle: CGFloat = 30,
        titleToSubTitle: CGFloat = 10,
        subTitleToIndicator: CGFloat? = nil,
        indicatorToButton: CGFloat = 40
    ) {
        self.uiContentHeight = uiContentHeight
        self.uiContentToTitle = uiContentToTitle
        self.titleToSubTitle = titleToSubTitle
        self.subTitleToIndicator = subTitleToIndicator
        self.indicatorToButton = indicatorToButton
    }
}
