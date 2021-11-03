//
//  String+Extensions.swift
//  VFGMVA10Foundation
//
//  Created by Erdem ILDIZ on 26.07.2021.
//  Copyright © 2021 Vodafone. All rights reserved.
//

import UIKit

public extension String {
    var isBlank: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func size(with font: UIFont) -> CGSize {
        var titleRect: CGRect?
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        titleRect = self.boundingRect(
            with: CGSize(width: Int.max, height: Int.max),
            options: .usesLineFragmentOrigin,
            attributes: [
                NSAttributedString.Key.font: font
            ],
            context: nil)
        if let titleRectWidth = titleRect?.size.width,
            let titleRectHeight = titleRect?.size.height {
            width = titleRectWidth
            height = titleRectHeight
        }
        return CGSize(width: width, height: height)
    }

    func replaceWithBlank(find key: String) -> String {
        return replacingOccurrences(of: key, with: "")
    }

    var toHTML: NSAttributedString? {
        guard
            let data = self.data(using: .unicode),
            let attrStr = try? NSAttributedString(
                data: data,
                options: [
                    NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html
                ],
                documentAttributes: nil)
        else { return nil }

        if #available(iOS 11.0, *) {
            let newFont = UIFontMetrics.default.scaledFont(for: .vodafoneRegular(17))
            let mattrStr = NSMutableAttributedString(attributedString: attrStr)
            mattrStr.beginEditing()
            mattrStr.enumerateAttribute(
                .font,
                in: NSRange(location: 0, length: mattrStr.length),
                options: .longestEffectiveRangeNotRequired) { value, range, _ in
                if
                    let oFont = value as? UIFont,
                    let newFontDescriptor = oFont
                        .fontDescriptor.withFamily(newFont.familyName)
                        .withSymbolicTraits(oFont.fontDescriptor.symbolicTraits)
                {
                    let nFont = UIFont(descriptor: newFontDescriptor, size: newFont.pointSize)
                    mattrStr.removeAttribute(.font, range: range)
                    mattrStr.addAttribute(.font, value: nFont, range: range)
                }
                mattrStr.endEditing()
            }
            return mattrStr
        } else {
            return self.htmlToAttributedString
        }
    }

    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(
                data: data,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
        } catch {
            return NSAttributedString()
        }
    }

    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var removeNewLines: String {
        return replacingOccurrences(of: "\\n", with: "")
    }

    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    func addBoldText(boldPartOfString: String, baseFont: UIFont, baseColor: UIColor, boldFont: UIFont, boldColor: UIColor) -> NSAttributedString {
        let baseAttributes = [
            NSAttributedString.Key.font: baseFont,
            NSAttributedString.Key.foregroundColor: baseColor
        ]
        let boldAttributes = [
            NSAttributedString.Key.font: boldFont,
            NSAttributedString.Key.foregroundColor: boldColor
        ]
        let attributedString = NSMutableAttributedString(string: self, attributes: baseAttributes)
        attributedString.addAttributes(
            boldAttributes,
            range: NSRange(
                self.range(of: boldPartOfString) ?? self.startIndex..<self.endIndex,
                in: self
            )
        )
        return attributedString
    }
}
