//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift

class SessionRepositoryImpl: SessionRepository {
    var playlistRepository: PlaylistRepository

    let onCurrentPlaylistSubject = BehaviorSubject<Playlist>(value: Playlist(id: "default", title: "Default", songs: []))
    var onCurrentPlaylist: Observable<Playlist> {
        return onCurrentPlaylistSubject.asObservable()
    }

    init (playlistRepository: PlaylistRepository) {
        self.playlistRepository = playlistRepository
        onCurrentPlaylistSubject.onNext(playlistRepository.defaultPlaylist())
    }

    func store(playlist: Playlist) {
    }

}
