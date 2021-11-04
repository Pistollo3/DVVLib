//
//  VFGPinCodeView.swift
//  VFGMVA10Foundation
//
//  Created by Hussein Kishk on 11/3/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

@objc public enum VFGPinCodeViewDeleteButtonAction: Int {
    /// Deletes the contents of the current field and moves the cursor to the previous field.
    case deleteCurrentAndMoveToPrevious = 0

    /// Simply deletes the content of the current field without moving the cursor.
    /// If there is no value in the field, the cursor moves to the previous field.
    case deleteCurrent

    /// Moves the cursor to the previous field and deletes the contents.
    /// When any field is focused, its contents are deleted.
    case moveToPreviousAndDelete
}

private class VFGPinCodeViewFlowLayout: UICollectionViewFlowLayout {
    override var developmentLayoutDirection: UIUserInterfaceLayoutDirection { return .leftToRight }
    override var flipsHorizontallyInOppositeLayoutDirection: Bool { return true }
}

@objcMembers
public class VFGPinCodeView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorView: UIView!
    // MARK: - Private Properties -

    var flowLayout: UICollectionViewFlowLayout {
        self.collectionView.collectionViewLayout = VFGPinCodeViewFlowLayout()
        return self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout ?? UICollectionViewFlowLayout()
    }

    var view: UIView?
    var reuseIdentifier = "VFGPinCodeCell"
    var isLoading = true
    var password: [String] = []
    var shouldEnableFields = true
    var textFields: [Int: UITextField] = [:]
    var selectedTextField: UITextField?

    // MARK: - Public Properties -
    @IBInspectable public var pinLength: Int = 4
    @IBInspectable public var secureCharacter: String = "\u{25CF}"
    @IBInspectable public var interSpace: CGFloat = 8
    @IBInspectable public var textColor: UIColor = .VFGDefaultInputText
    @IBInspectable public var shouldSecureText: Bool = true
    @IBInspectable public var secureTextDelay: Int = 0
    @IBInspectable public var allowsWhitespaces: Bool = false
    @IBInspectable public var placeholder: String = ""

    @IBInspectable public var borderLineColor: UIColor = .VFGDefaultInputOutline
    @IBInspectable public var activeBorderLineColor: UIColor = .VFGSelectedInputOutline
    @IBInspectable public var borderLineThickness: CGFloat = 1
    @IBInspectable public var activeBorderLineThickness: CGFloat = 2

    @IBInspectable public var fieldBackgroundColor: UIColor = UIColor.clear
    @IBInspectable public var activeFieldBackgroundColor: UIColor = UIColor.clear

    @IBInspectable public var fieldCornerRadius: CGFloat = 6
    @IBInspectable public var activeFieldCornerRadius: CGFloat = 6

    public var deleteButtonAction: VFGPinCodeViewDeleteButtonAction = .moveToPreviousAndDelete

    public var font = UIFont.vodafoneLite(22)
    public var keyboardType = UIKeyboardType.phonePad
    public var keyboardAppearance: UIKeyboardAppearance = .default
    public var becomeFirstResponderAtIndex: Int?
    public var isContentTypeOneTimeCode = true
    public var shouldDismissKeyboardOnEmptyFirstField = false

    public var hasError = false {
        didSet {
            updateBorders()
        }
    }

    public var pinInputAccessoryView = { () -> UIView in
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
            target: nil,
            action: nil)
        let done = UIBarButtonItem(
            title: "done".localized(),
            style: UIBarButtonItem.Style.done,
            target: self,
            action: #selector(dismissKeyboard))

        var items: [UIBarButtonItem] = []
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()
        return doneToolbar
    }

    public var didFinishCallback: ((String) -> Void)?
    public var didChangeCallback: ((String) -> Void)?

    // MARK: - Init methods -
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }

    func loadView(completionHandler: (() -> Void)? = nil) {
        let nib = UINib(nibName: "VFGPinCodeView", bundle: Bundle.foundation)
        view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        guard let view = view else { return }
        // for CollectionView
        let collectionViewNib = UINib(nibName: "VFGPinCodeCell", bundle: Bundle.foundation)
        collectionView.register(collectionViewNib, forCellWithReuseIdentifier: reuseIdentifier)
        flowLayout.scrollDirection = .vertical
        collectionView.isScrollEnabled = false

        self.addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completionHandler?()
        }
    }

    // MARK: - Private methods -
    func handleErrorState() {
        if hasError {
            hasError = false
            for index in 1...pinLength - 1 {
                if let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)),
                    let containerView = cell.viewWithTag(51) {
                    containerView.layer.borderWidth = borderLineThickness
                    containerView.layer.borderColor = borderLineColor.cgColor
                }
            }
        }
    }

    func validateAndSendCallback() {
        didChangeCallback?(password.joined())

        let pin = getPin()
        guard !pin.isEmpty else { return }
        didFinishCallback?(pin)
    }

    func setPlaceholder() {
        for (index, char) in placeholder.enumerated() {
            guard index < pinLength else { return }

            if let placeholderLabel = collectionView.cellForItem(
                at: IndexPath(
                    item: index,
                    section: 0))?
                .viewWithTag(400) as? UILabel {
                placeholderLabel.text = String(char)
            } else { showPinError(error: "ERR-102: Type Mismatch") }
        }
    }

    func stylePinField(containerView: UIView, isActive: Bool) {
        containerView.backgroundColor = isActive ? activeFieldBackgroundColor : fieldBackgroundColor
        containerView.layer.cornerRadius = isActive ? activeFieldCornerRadius : fieldCornerRadius
        containerView.layer.borderWidth = isActive ? activeBorderLineThickness : borderLineThickness
        containerView.layer.borderColor = isActive ? activeBorderLineColor.cgColor : borderLineColor.cgColor
    }

    @IBAction func refreshPinView(completionHandler: (() -> Void)? = nil) {
        view?.removeFromSuperview()
        view = nil
        isLoading = true
        errorView.isHidden = true
        loadView(completionHandler: completionHandler)
    }

    func showPinError(error: String) {
        errorView.isHidden = false
        print("\n----------VFGPinCodeField Error----------")
        print(error)
        print("-----------------------------------")
    }

    public func setErrorState(hasError: Bool) {
        self.hasError = hasError
    }

    public func enableFields() {
        shouldEnableFields = true
        textFields.forEach {
            $0.value.isEnabled = true
            stylePinField(containerView: $0.value.superview ?? UIView(), isActive: false)
        }
        selectedTextField?.becomeFirstResponder()
        stylePinField(containerView: selectedTextField?.superview ?? UIView(), isActive: true)
    }

    public func disableFields() {
        shouldEnableFields = false
        textFields.forEach {
            $0.value.isEnabled = false
            stylePinField(containerView: $0.value.superview ?? UIView(), isActive: false)
        }
    }

    func updateBorders() {
        if hasError {
            borderLineColor = .VFGErrorInputOutline
            activeBorderLineColor = .VFGErrorInputOutline
            activeBorderLineThickness = 1
        } else {
            borderLineColor = .VFGDefaultInputOutline
            activeBorderLineColor = .VFGSelectedInputOutline
            activeBorderLineThickness = 2
        }
    }
}
