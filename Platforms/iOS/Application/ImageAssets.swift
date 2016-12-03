//
// Created by Nguyen Thanh Hai on 12/3/16.
//

import Foundation
import UIKit

#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit.UIImage
typealias Image = UIImage
#elseif os(OSX)
import AppKit.NSImage
typealias Image = NSImage
#endif

enum ImageAssets: String {
    case Icon_Close = "Icon_Close"

    var image: Image {
        return Image(asset: self)
    }
}

extension Image {
    convenience init!(asset: ImageAssets) {
        self.init(named: asset.rawValue)
    }
}
