//
//  VFGTutorialViewController.swift
//  VFGLogin
//
//  Created by Mohamed Mahmoud Zaki on 2/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import Lottie

open class VFGTutorialViewController: UIViewController {
    @IBOutlet weak var primaryButton: VFGButton!
    @IBOutlet weak var secondaryButton: VFGButton!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var itemsStackView: UIStackView!
    @IBOutlet weak var itemsScrollView: UIScrollView!
    @IBOutlet weak var uiContentToTitleConstraint: NSLayoutConstraint!
    @IBOutlet weak var subTitleToIndicatorConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicatorToButtonConstraint: NSLayoutConstraint!

    var currentAnimation: String?
    var currentPage = 0
    public weak var delegate: VFGTutorialManagerProtocol?
    public var dataSource: VFGTutorialProtocol?
    static var margins: VFGTutorialMarginsModel?
    public var analyticsManager = VFGAnalyticsManager.self

    public class func viewController(
        with dataModel: VFGTutorialProtocol?,
        customMargins: VFGTutorialMarginsModel? = nil
    ) -> VFGTutorialViewController {
        margins = customMargins

        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.foundation)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "VFGTutorialViewController")
            as? VFGTutorialViewController else {
                return VFGTutorialViewController()
        }
        viewController.dataSource = dataModel
        return viewController
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        setupUIContent()
        setupButtons(at: 0)
        pageControl.numberOfPages = dataSource?.item?.count ?? 0
        setupMargins(model: VFGTutorialViewController.margins ?? VFGTutorialMarginsModel())
        setupItems(model: VFGTutorialViewController.margins ?? VFGTutorialMarginsModel())
        if  UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            itemsScrollView.transform = CGAffineTransform(scaleX: -1, y: 1)
            itemsStackView.transform = CGAffineTransform(scaleX: -1, y: 1)
        }
        trackView()
    }

    private func setupItems(model: VFGTutorialMarginsModel) {
        for index in 0..<(dataSource?.item?.count ?? 0) {
            guard let itemView: VFGTutorialItemView = UIView.loadXib(bundle: .foundation) else {
                return
            }
            itemView.configure(
                titleText: dataSource?.item?[index].title,
                titleFont: dataSource?.item?[index].titleFont ?? .vodafoneLite(29),
                descriptionText: dataSource?.item?[index].description,
                descriptionFont: dataSource?.item?[index].descriptionFont
                    ?? .vodafoneRegular(19),
                titleToSubTitleMargin: VFGTutorialViewController.margins?.titleToSubTitle ?? 10,
                image: dataSource?.item?[index].image)
            itemView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
            if dataSource?.item?[index].image == nil {
                itemView.tutorialImageView.isHidden = true
            } else {
                itemsScrollView.topAnchor.constraint(equalTo: animationView.topAnchor).isActive = true
                itemView.tutorialImageView.heightAnchor.constraint(
                    equalToConstant: model.uiContentHeight).isActive = true
            }
            itemsStackView.addArrangedSubview(itemView)
        }
    }

    private func setupUIContent() {
        if let image = dataSource?.item?.first?.image {
            showImageView(
                with: image,
                backgroundColor: dataSource?.item?[0].imageBackgroundColor)
            return
        }
        showAnimationView()
        animationView.animation = Animation.named(
            dataSource?.item?.first?.fileName ?? "",
            bundle: dataSource?.animationFileBundle ?? Bundle.main
        )
        currentAnimation = dataSource?.item?.first?.fileName
        animationView.play(
            fromFrame: dataSource?.item?.first?.startingFrame,
            toFrame: dataSource?.item?.first?.endingFrame ?? 0,
            completion: nil
        )
        animationView.contentMode = .scaleAspectFit
    }

    private func setupButtons(at index: Int) {
        guard
            let items = dataSource?.item,
            index < items.count else { return }
        var primaryTitle: String?
        var secondaryTitle: String?

        if let customTitles = items[index].customButtonsTitles {
            primaryTitle = customTitles.primary
            secondaryTitle = customTitles.secondary
        } else {
            primaryTitle = dataSource?.firstButtonTitle
            secondaryTitle = dataSource?.secondButtonTitle
        }

        if let primaryTitle = primaryTitle {
            primaryButton.setTitle(primaryTitle, for: .normal)
            primaryButton.accessibilityIdentifier = "loginLoginTutorial"
            primaryButton.isHidden = false
        } else {
            primaryButton.isHidden = true
        }

        if let secondaryTitle = secondaryTitle {
            secondaryButton.setTitle(secondaryTitle, for: .normal)
            secondaryButton.accessibilityIdentifier = "loginRegisterTutorial"
            secondaryButton.isHidden = false
        } else {
            secondaryButton.isHidden = true
        }
    }

    public func moveToNextPage(animated: Bool = true) {
        guard currentPage < (dataSource?.item?.count ?? 0) - 1 else { return }
        let newPage = currentPage + 1
        updateSelection(oldPage: currentPage, newPage: newPage, animated: animated)
        pageControl.currentPage = newPage
    }

    public func moveToPreviousPage(animated: Bool = true) {
        guard currentPage > 0 else { return }
        let newPage = currentPage - 1
        updateSelection(oldPage: currentPage, newPage: newPage, animated: animated)
        pageControl.currentPage = newPage
    }

    private func setupMargins(model: VFGTutorialMarginsModel) {
        let minimumPadding: CGFloat = 17
        animationView.heightAnchor.constraint(equalToConstant: model.uiContentHeight).isActive = true
        uiContentToTitleConstraint.constant = model.uiContentToTitle
        if let subTitleToIndicator = model.subTitleToIndicator {
            subTitleToIndicatorConstraint.constant = subTitleToIndicator
            indicatorToButtonConstraint.isActive = false
            indicatorToButtonConstraint = pageControl.bottomAnchor.constraint(
                lessThanOrEqualTo: primaryButton.topAnchor,
                constant: -minimumPadding)
            indicatorToButtonConstraint.isActive = true
        } else {
            indicatorToButtonConstraint.constant = model.indicatorToButton
            subTitleToIndicatorConstraint.isActive = false
            subTitleToIndicatorConstraint = pageControl.topAnchor.constraint(
                greaterThanOrEqualTo: itemsScrollView.bottomAnchor,
                constant: minimumPadding)
            subTitleToIndicatorConstraint.isActive = true
        }
        view.layoutIfNeeded()
    }

    @IBAction func primaryButtonDidPress(_ sender: Any) {
        delegate?.primaryButtonTapped(self, at: currentPage)
    }

    @IBAction func secondaryButtonDidPress(_ sender: Any) {
        delegate?.secondaryButtonTapped(self, at: currentPage)
    }

    @IBAction func pageControlValueChanged(_ sender: UIPageControl) {
        let newPage = sender.currentPage
        updateSelection(oldPage: currentPage, newPage: newPage, animated: false)
    }

    func updateSelection(oldPage: Int, newPage: Int, animated: Bool) {
        delegate?.tutorialViewController(self, willMoveFromStepAt: oldPage)
        let x = CGFloat(newPage) * itemsScrollView.frame.size.width
        itemsScrollView.setContentOffset(CGPoint(x: x, y: .zero), animated: true)
        updateUIContent(oldPage: currentPage, newPage: newPage)
        setupButtons(at: newPage)
        currentPage = newPage
        delegate?.tutorialViewController(self, didMoveToStepAt: newPage)
    }
}

extension VFGTutorialViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cellWidth = view.frame.width
        let oldPage = pageControl.currentPage
        let offsetX = scrollView.contentOffset.x
        let newPage = Int(offsetX / cellWidth)
        delegate?.tutorialViewController(self, willMoveFromStepAt: oldPage)
        updatePaging(newPage)
        updateUIContent(oldPage: oldPage, newPage: newPage)
        setupButtons(at: newPage)
        delegate?.tutorialViewController(self, didMoveToStepAt: newPage)
    }

    func updatePaging(_ newPage: Int) {
        pageControl.currentPage = newPage
        currentPage = newPage
    }

    func updateUIContent(oldPage: Int, newPage: Int) {
        guard
            oldPage != newPage,
            dataSource?.item?.count ?? 0 > newPage else { return }
        if let image = dataSource?.item?[newPage].image {
            showImageView(
                with: image,
                backgroundColor: dataSource?.item?[newPage].imageBackgroundColor)
        } else {
            showAnimationView()
            setupAnimation(at: newPage)
        }
    }

    private func setupAnimation(at index: Int) {
        if currentAnimation == dataSource?.item?[index].fileName {
            animationView.play(
                fromFrame: dataSource?.item?[index].startingFrame,
                toFrame: dataSource?.item?[index].endingFrame ?? 0,
                completion: nil)
        } else {
            currentAnimation = dataSource?.item?[index].fileName
            animationView.animation = Animation.named(
                dataSource?.item?[index].fileName ?? "",
                bundle: dataSource?.animationFileBundle ?? Bundle.main)
            animationView.play()
        }
    }

    private func showAnimationView() {
        animationView.isHidden = false
    }

    private func showImageView(with image: UIImage, backgroundColor: UIColor?) {
        animationView.isHidden = true
    }
}

// MARK: - Tealuim Tags
extension VFGTutorialViewController {
    func trackView() {
        let journeyType = "Pre-Onboarding Tutorial"
        let parameters: [String: String] = [
            VFGAnalyticsKeys.pageName: journeyType,
            VFGAnalyticsKeys.journeyType: journeyType
        ]
        analyticsManager.trackView( parameters: parameters, bundle: .foundation)
    }
}
