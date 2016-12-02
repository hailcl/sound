//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift

class PlaylistServiceImpl: PlaylistService {
    var playlistRepository: PlaylistRepository
    var sessionRepository: SessionRepository

    var onCurrentPlaylist: Observable<Playlist>

    init(playlistRepository: PlaylistRepository, sessionRepository: SessionRepository) {
        onCurrentPlaylist = sessionRepository.onCurrentPlaylist
        self.playlistRepository = playlistRepository
        self.sessionRepository = sessionRepository
    }
}
