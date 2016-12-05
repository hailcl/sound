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

// swiftlint:disable file_length
// swiftlint:disable line_length

// swiftlint:disable type_body_length
enum Asset: String {
    case Icon_pause = "icon_pause"
    case Icon_play = "icon_play"
    case Icon_playback_white = "icon_playback_white"
    case Icon_playing = "icon_playing"
    case Icon_repeat_all = "icon_repeat_all"
    case Icon_shuffle = "icon_shuffle"
    case Icon_Nav_Back = "icon-nav-back"
    
    var image: Image {
        return Image(asset: self)
    }
}
// swiftlint:enable type_body_length

extension Image {
    convenience init!(asset: Asset) {
        self.init(named: asset.rawValue)
    }
}
