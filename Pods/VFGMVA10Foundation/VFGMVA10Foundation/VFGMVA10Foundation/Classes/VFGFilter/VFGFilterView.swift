//
//  VFGFilterView.swift
//  VFGMVA10Foundation
//
//  Created by Esraa Eldaltony on 11/5/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public class VFGFilterView: UIView {
    @IBOutlet var view: UIView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!

    let categoryEstimatedHeight: CGFloat = 35
    let filterViewShimmerCellsCount = 5
    let categoryEstimatedWidth: CGFloat = 100
    let categoryIntermidiateSpacing: CGFloat = 12.0
    let categoryCellNibName = "VFGFilterCell"
    let categoryCellShimmerNibName = "VFGFilterCellShimmer"
    let categoryCellId = "VFGFilterCellId"
    let categoryCellShimmerId = "VFGFilterCellShimmerId"
    public var filterCollectionView: UICollectionView?
    public var filterUnselectedBackgroundColor: UIColor?

    public var triggerShimmerMode = false {
        didSet {
            categoryCollectionView.reloadData()
            filterCollectionView?.isScrollEnabled = !triggerShimmerMode
        }
    }

    public var categories: [String] = [] {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    public var selectedCategories: [String] = []

    public weak var collectionViewDelegate: UICollectionViewDelegate? {
        didSet {
            categoryCollectionView.delegate = collectionViewDelegate
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib(nibName: "VFGFilterView")
        xibSetup(contentView: view)
        setupCategoriesCollectionView()
    }
}

extension VFGFilterView: UICollectionViewDataSource {
    func setupCategoriesCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.isScrollEnabled = true
        categoryCollectionView.allowsMultipleSelection = true

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = CGSize(
            width: categoryEstimatedWidth,
            height: categoryEstimatedHeight)
        flowLayout.minimumInteritemSpacing = categoryIntermidiateSpacing
        categoryCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        categoryCollectionView.contentInset = UIEdgeInsets.zero

        let categoryCell = UINib(nibName: categoryCellNibName, bundle: .foundation)

        let categoryShimmerCell = UINib(nibName: categoryCellShimmerNibName, bundle: .foundation)
        categoryCollectionView.register(
            categoryCell,
            forCellWithReuseIdentifier: categoryCellId)
        categoryCollectionView.register(
            categoryShimmerCell,
            forCellWithReuseIdentifier: categoryCellShimmerId)
        filterCollectionView = categoryCollectionView
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return triggerShimmerMode ? filterViewShimmerCellsCount : categories.count
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        return filterCollectionViewCell(at: indexPath)
    }
}

extension VFGFilterView {
    func filterCollectionViewCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let shimmerCell = categoryCollectionView.dequeueReusableCell(
            withReuseIdentifier: categoryCellShimmerId,
            for: indexPath) as? VFGFilterCellShimmer

        if triggerShimmerMode {
            shimmerCell?.startShimmer()
            return shimmerCell ?? VFGFilterCellShimmer()
        } else {
            shimmerCell?.stopShimmer()

            guard
                let cell = categoryCollectionView.dequeueReusableCell(
                    withReuseIdentifier: categoryCellId,
                    for: indexPath) as? VFGFilterCell else {
                return UICollectionViewCell()
            }

            let type = categories[indexPath.row]
            cell.categoryType = type
            cell.nameLabel.accessibilityIdentifier = "Flabel\(indexPath.row)"
            cell.filterUnselectedBackgroundColor = filterUnselectedBackgroundColor ?? .VFGFilterUnselectedBg
            cell.isSelected = selectedCategories.contains(type)
            return cell
        }
    }
}
