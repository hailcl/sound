//
// Created by Nguyen Thanh Hai on 12/5/16.
//

import Foundation

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIFont
typealias Font = UIFont
#elseif os(OSX)
import AppKit.NSFont
typealias Font = NSFont
#endif

// swiftlint:disable file_length
// swiftlint:disable line_length

protocol FontConvertible {
    func font(size: CGFloat) -> Font!
}

extension FontConvertible where Self: RawRepresentable, Self.RawValue == String {
    func font(size: CGFloat) -> Font! {
        return Font(font: self, size: size)
    }
}

extension Font {
    convenience init!<FontType: FontConvertible>
        (font: FontType, size: CGFloat)
        where FontType: RawRepresentable, FontType.RawValue == String {
        self.init(name: font.rawValue, size: size)
    }
}

struct FontFamily {
    enum Roboto: String, FontConvertible {
        case Black = "Roboto-Black"
        case BlackItalic = "Roboto-BlackItalic"
        case Bold = "Roboto-Bold"
        case BoldItalic = "Roboto-BoldItalic"
        case Italic = "Roboto-Italic"
        case Light = "Roboto-Light"
        case LightItalic = "Roboto-LightItalic"
        case Medium = "Roboto-Medium"
        case MediumItalic = "Roboto-MediumItalic"
        case Regular = "Roboto-Regular"
        case Thin = "Roboto-Thin"
        case ThinItalic = "Roboto-ThinItalic"
    }
}
