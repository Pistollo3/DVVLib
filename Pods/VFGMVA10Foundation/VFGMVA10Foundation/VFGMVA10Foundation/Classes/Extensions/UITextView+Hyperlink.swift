//
//  UITextView+Hyperlink.swift
//  VFGMVA10Foundation
//
//  Created by Ahmed Sultan on 10/21/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public typealias VFGHyperLink = (link: String, target: String)

extension UITextView {
    public func hyperLink(
        originalText: String,
        hyperLinks: [VFGHyperLink],
        linkColor: UIColor,
        alignment: NSTextAlignment = NSTextAlignment.left,
        font: UIFont,
        textColor: UIColor = UIColor.VFGLinkText,
        direction: NSString.CompareOptions = .caseInsensitive
    ) {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment

        text = originalText
        let attributedOriginalText = NSMutableAttributedString(string: text)
        let linkRanges = hyperLinks.map {
            attributedOriginalText.mutableString.range(
                of: $0.link,
                options: direction
            )
        }
        let fullRange = attributedOriginalText.mutableString.range(of: text)

        attributedOriginalText.addAttributes(
            [
                .paragraphStyle: style,
                .foregroundColor: textColor,
                .font: font
            ],
            range: fullRange)

        linkRanges.enumerated().forEach {
            attributedOriginalText.addAttribute(
                .link,
                value: hyperLinks[$0.offset].target,
                range: $0.element)

            attributedOriginalText.addAttribute(
                .foregroundColor,
                value: linkColor,
                range: $0.element
            )
        }

        self.linkTextAttributes = [
            kCTForegroundColorAttributeName: linkColor,
            kCTUnderlineStyleAttributeName: NSUnderlineStyle.single.rawValue
        ] as [NSAttributedString.Key: Any]

        self.attributedText = attributedOriginalText
    }
}
