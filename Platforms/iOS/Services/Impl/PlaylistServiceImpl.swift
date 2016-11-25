//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift

class PlaylistServiceImpl: PlaylistService {
    let onCurrentPlaylistSubject = BehaviorSubject<Playlist>(value: { return Playlist() }())

    var onCurrentPlaylist: Observable<Playlist> {
        return onCurrentPlaylistSubject.asObservable()
    }

}
