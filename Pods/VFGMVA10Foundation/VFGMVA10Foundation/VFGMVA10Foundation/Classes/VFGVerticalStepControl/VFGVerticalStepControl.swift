//
//  VFGVerticalStepControl.swift
//  VFGMVA10Foundation
//
//  Created by Sandra Morcos on 2/11/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import UIKit

public class VFGVerticalStepControl: UIView {
    public weak var dataSource: VFGVerticalStepControlDataSource?
    public weak var delegate: VFGVerticalStepControlDelegate?
    var stepsContainerViews: [VFGVerticalStepView] = []
    var heightConstraints: [NSLayoutConstraint] = []
    var currentIndex = 0
    var numberOfSteps: Int {
        dataSource?.numberOfSteps(self) ?? 0
    }

    let collapsedHeight: CGFloat = 60

    private var visibleView: UIView? {
        for index in 0..<stepsContainerViews.count
            where stepsContainerViews[index].stepEntry?.stepView.superview != nil {
                return stepsContainerViews[index].stepEntry?.stepView
        }
        return nil
    }

    var visibleArea: CGRect {
        guard let visibleView = visibleView else {
            return CGRect.zero
        }
        return convert(visibleView.frame, to: nil)
    }

    public func setup() {
        for index in 0..<numberOfSteps {
            setupStep(at: index)
        }
        clipsToBounds = true
    }

    func setupStep(at index: Int) {
        let containerView = VFGVerticalStepView()
        containerView.stepEntry = dataSource?.stepEntry(self, at: index)
        containerView.data = dataSource?.stepEntry(self, at: index)?.data
        containerView.delegate = self
        stepsContainerViews.append(containerView)
        addSubview(containerView)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        if index == 0 {
            containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        } else {
            let previousStep = stepsContainerViews[index - 1]
            containerView.topAnchor.constraint(equalTo: previousStep.bottomAnchor).isActive = true
        }

        let isLastStep = index == numberOfSteps - 1
        if isLastStep {
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        let heightConstraint = containerView.heightAnchor.constraint(equalToConstant: collapsedHeight)
        heightConstraint.priority = UILayoutPriority.defaultLow
        heightConstraint.isActive = true
        heightConstraints.append(heightConstraint)

        let savedAction = dataSource?.savedAction(self, forStepAt: index)
        containerView.setupStepView(
            isLastStep: isLastStep,
            stepNumber: index,
            savedAction: savedAction)
        if savedAction == .start {
            currentIndex = index
            start()
        }
    }
}

// MARK: - VFGStepContainerView Handlers
extension VFGVerticalStepControl {
    public func start() {
        stepsContainerViews[currentIndex].action = .start
        stepsContainerViews[currentIndex].stepEntry?.sideView?.isHidden = false
        layoutSubviews()
        delegate?.stepControl(self, didMoveToStepAt: currentIndex)
    }

    public func complete() {
        stepsContainerViews[currentIndex].stepEntry?.sideView?.isHidden = true
        stepsContainerViews[currentIndex].action = .complete
        delegate?.stepControl(self, didCompleteStepAt: currentIndex)
        delegate?.stepControl(self, willMoveFromStepAt: currentIndex)
        if currentIndex < numberOfSteps - 1 {
            currentIndex += 1
            start()
        }
    }

    public func skip() {
        stepsContainerViews[currentIndex].stepEntry?.sideView?.isHidden = true
        stepsContainerViews[currentIndex].action = .skip
        delegate?.stepControl(self, didSkipStepAt: currentIndex)
        delegate?.stepControl(self, willMoveFromStepAt: currentIndex)
        if currentIndex < numberOfSteps - 1 {
            currentIndex += 1
            start()
        }
    }

    public func backToPrevious() {
        stepsContainerViews[currentIndex].action = .returnToPreviousStep
        delegate?.stepControl(self, didReturnToStepAt: currentIndex)
        delegate?.stepControl(self, willMoveFromStepAt: currentIndex)
        if currentIndex > 0 {
            currentIndex -= 1
            start()
        }
    }

    public func perform(action: VFGStepAction) {
        switch action {
        case .start:
            start()
        case .complete:
            complete()
        case .skip:
            skip()
        case .returnToPreviousStep:
            backToPrevious()
        default:
            break
        }
    }

    public func stepView(at index: Int) -> VFGVerticalStepView? {
        guard
            !stepsContainerViews.isEmpty,
            0..<stepsContainerViews.count ~= index else { return nil }
        return stepsContainerViews[index]
    }
}

// MARK: - VFGVerticalStepViewDelegate
extension VFGVerticalStepControl: VFGVerticalStepViewDelegate {
    func didPress(at newIndex: Int) {
        guard dataSource?.enableTapAction ?? false else {
            return
        }
        if currentIndex == newIndex {
            if stepsContainerViews[currentIndex].action != .start {
                stepsContainerViews[currentIndex].action = .start
                start()
            }
            delegate?.stepControl(self, didSelectStepAt: newIndex)
            return
        }
        guard newIndex < currentIndex else { return }
        for index in newIndex + 1...currentIndex {
            stepsContainerViews[index].stepEntry?.sideView?.isHidden = true
            stepsContainerViews[index].markUnVisited()
        }
        currentIndex = newIndex
        start()
        delegate?.stepControl(self, didSelectStepAt: newIndex)
    }
}
