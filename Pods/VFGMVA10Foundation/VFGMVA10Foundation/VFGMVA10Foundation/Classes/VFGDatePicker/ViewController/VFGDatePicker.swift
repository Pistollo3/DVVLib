//
//  VFGDatePicker.swift
//  VFGMVA10Foundation
//
//  Created by Yahya Saddiq on 13/09/2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

public class VFGDatePicker: UIView {
    // MARK: Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var headerView = VFGDatePickerHeaderView(
        didTapLastMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }

            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: -1,
                to: self.baseDate
            ) ?? self.baseDate
        },
        didTapNextMonthCompletionHandler: { [weak self] in
            guard let self = self else { return }

            self.baseDate = self.calendar.date(
                byAdding: .month,
                value: 1,
                to: self.baseDate
            ) ?? self.baseDate
        },
        datePicker: self
    )

    // MARK: Non-public Properties
    lazy var calendar: Calendar = {
        var calendar = Calendar.current
        if let timeZone = TimeZone(secondsFromGMT: 0) {
            calendar.timeZone = timeZone
        }
        return calendar
    }()

    lazy var collectionViewTrailingAnchor = collectionView.trailingAnchor.constraint(
        equalTo: trailingAnchor
    )
    lazy var headerViewTrailingAnchor = headerView.trailingAnchor.constraint(
        equalTo: collectionView.trailingAnchor
    )

    lazy var days: [VFGDay] = generateDaysInMonth(for: baseDate)

    var numberOfWeeksInBaseDate: Int {
        calendar.range(of: .weekOfMonth, in: .month, for: baseDate)?.count ?? 0
    }

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()

    // MARK: - Public properties
    public weak var delegate: VFGDatePickerDelegate?
    public weak var dataSource: VFGDatePickerDataSource? {
        didSet {
            headerView.buildDayOfWeek()
            reloadData()
        }
    }
    public weak var appearance: VFGDatePickerAppearance?
    public var gapless = false
    public var type = VFGDatePickerType.singleSelection
    public var startDate: Date?
    public var endDate: Date?
    public var minimumDate: Date? {
        didSet {
            guard let minimumDate = minimumDate else {
                return
            }
            let minimumDateComponents = calendar.dateComponents([.day, .month, .year], from: minimumDate)
            self.minimumDate = calendar.date(from: minimumDateComponents)
            headerView.toggleChevronsVisibility()
        }
    }
    public var maximumDate: Date? {
        didSet {
            guard let maximumDate = maximumDate else {
                return
            }
            let maximumDateComponents = calendar.dateComponents([.day, .month, .year], from: maximumDate)
            self.maximumDate = calendar.date(from: maximumDateComponents)
            headerView.toggleChevronsVisibility()
        }
    }
    public var baseDate = Date() {
        didSet {
            days = generateDaysInMonth(for: baseDate)
            collectionView.reloadData()
            headerView.baseDate = baseDate
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    func setupView() {
        collectionView.backgroundColor = .VFGWhiteBackground

        addSubview(collectionView)
        addSubview(headerView)

        var constraints = [
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionViewTrailingAnchor,
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ]

        constraints.append(contentsOf: [
            headerView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            headerViewTrailingAnchor,
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)
        ])

        NSLayoutConstraint.activate(constraints)

        collectionView.register(
            VFGDatePickerCollectionViewCell.self,
            forCellWithReuseIdentifier: VFGDatePickerCollectionViewCell.reuseIdentifier
        )

        collectionView.dataSource = self
        collectionView.delegate = self
        headerView.baseDate = baseDate
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        adjustCollectionViewWidthIfNeeded()
    }

    public func reloadData() {
        days = generateDaysInMonth(for: baseDate)
        collectionView.reloadData()
    }
}

public enum VFGDatePickerType {
    case singleSelection
    case rangeSelection
}
