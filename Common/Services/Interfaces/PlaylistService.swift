//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift

protocol PlaylistService {
    var onCurrentPlaylist: Observable<Playlist> { get }
}