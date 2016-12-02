//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift
import CocoaLumberjackSwift

class HomeViewModel: BaseViewModel {
    var playlistService: PlaylistService
    var onPlaylist: Observable<PlaylistViewModel> {
        return onPlaylistSubject.asObservable()
    }
    var onSongs: Observable<[SongViewModel]> { return onSongsSubject.asObservable() }

    let onPlaylistSubject = PublishSubject<PlaylistViewModel>()
    let onSongsSubject = BehaviorSubject<[SongViewModel]>(value: [])

    init (playlistService: PlaylistService) {
        self.playlistService = playlistService
    }

    func loadPlaylist() {
        _ = playlistService.onCurrentPlaylist.subscribe(
                onNext: { [unowned self] playlist in
                    self.onPlaylistSubject.onNext(PlaylistViewModel(id: playlist.id, title: playlist.title,
                            songs: playlist.songs.map{ (Song) -> (SongViewModel) in return SongViewModel() }))
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    func loadSongs() {
        _ = onPlaylist.takeLast(1).subscribe(onNext: { [unowned self] playlistViewModel in
            self.onSongsSubject.onNext(playlistViewModel.songs.map{(Song) -> (SongViewModel) in return SongViewModel()})
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}
