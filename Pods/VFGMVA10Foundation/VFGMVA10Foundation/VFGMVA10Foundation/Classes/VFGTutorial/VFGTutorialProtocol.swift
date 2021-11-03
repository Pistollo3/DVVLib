//
//  VFGTutorialProtocol.swift
//  VFGLogin
//
//  Created by Mohamed Mahmoud Zaki on 2/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGTutorialManagerProtocol: class {
    func primaryButtonTapped(_ tutorialViewController: VFGTutorialViewController, at index: Int)
    func secondaryButtonTapped(_ tutorialViewController: VFGTutorialViewController, at index: Int)
    func tutorialViewController(_ tutorialViewController: VFGTutorialViewController, didMoveToStepAt index: Int)
    func tutorialViewController(_ tutorialViewController: VFGTutorialViewController, willMoveFromStepAt index: Int)
}

extension VFGTutorialManagerProtocol {
    public func primaryButtonTapped(_ tutorialViewController: VFGTutorialViewController, at index: Int) {}
    public func secondaryButtonTapped(_ tutorialViewController: VFGTutorialViewController, at index: Int) {}
    public func tutorialViewController(_ tutorialViewController: VFGTutorialViewController, didMoveToStepAt index: Int) {}
    public func tutorialViewController(_ tutorialViewController: VFGTutorialViewController, willMoveFromStepAt index: Int) {}
}

public protocol VFGTutorialProtocol {
    var item: [VFGTutorialItemProtocol]? { get }
    var animationFileBundle: Bundle? { get }
    var firstButtonTitle: String? { get }
    var secondButtonTitle: String? { get }
}

public protocol VFGTutorialItemProtocol {
    var title: String? { get }
    var titleFont: UIFont? { get }
    var description: String? { get }
    var descriptionFont: UIFont? { get }
    var fileName: String? { get }
    var image: UIImage? { get }
    var imageBackgroundColor: UIColor? { get }
    var customButtonsTitles: (primary: String?, secondary: String?)? { get }
    var startingFrame: CGFloat? { get }
    var endingFrame: CGFloat? { get }
}

extension VFGTutorialItemProtocol {
    public var titleFont: UIFont? { nil }
    public var descriptionFont: UIFont? { nil }
    public var image: UIImage? { nil }
    public var imageBackgroundColor: UIColor? { nil }
    public var customButtonsTitles: (primary: String?, secondary: String?)? { nil }
}
