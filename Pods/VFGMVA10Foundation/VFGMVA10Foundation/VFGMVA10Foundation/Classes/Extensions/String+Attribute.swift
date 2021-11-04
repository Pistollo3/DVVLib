//
//  String+Attribute.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import Foundation

public extension String {
    func toAttributedString() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttributes(
            attributes,
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }

    func addAttribute(to text: String, name: NSAttributedString.Key, value: Any) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        guard !text.isBlank else {
            return attributedString
        }
        let range = (self as NSString).range(of: text)
        attributedString.addAttribute(name, value: value, range: range)
        return attributedString
    }

    func strikeThrough(lineColor color: UIColor = .VFGRedText, textColor: UIColor = .VFGPrimaryText) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        attributedString.addAttribute(
            NSAttributedString.Key.strikethroughColor,
            value: color,
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }

    func underLine() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: NSUnderlineStyle.single.rawValue,
            range: NSRange(location: 0, length: attributedString.length)
        )
        return attributedString
    }

    func encodeWithEmojis() -> String? {
        guard let data = self.data(using: .nonLossyASCII, allowLossyConversion: true) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    func decodeWithEmojis() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        return String(data: data, encoding: .nonLossyASCII) ?? self
    }
}
