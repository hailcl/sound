//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift
import CocoaLumberjackSwift

class HomeViewModel: BaseViewModel {
    var playlistService: PlaylistService
    var soundService: SoundService
    var onPlaylist: Observable<PlaylistViewModel> {
        return onPlaylistSubject.asObservable().shareReplay(1)
    }
    var onSongs: Observable<[SongViewModel]> { return onSongsSubject.asObservable() }

    let onPlaylistSubject = PublishSubject<PlaylistViewModel>()
    let onSongsSubject = BehaviorSubject<[SongViewModel]>(value: [])

    init (playlistService: PlaylistService, soundService: SoundService) {
        self.playlistService = playlistService
        self.soundService = soundService
    }

    func loadPlaylist() {
        _ = playlistService.onCurrentPlaylist.subscribe(
                onNext: { [unowned self] playlist in
                    self.onPlaylistSubject.onNext(PlaylistViewModel(id: playlist.id, title: playlist.title,
                            songs: playlist.songs.map{ (song: Song) -> SongViewModel in
                                return SongViewModel(id: song.id, title: song.title, path: song.path)
                            }))
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    func loadSongs() {
        _ = playlistService.onCurrentPlaylist.take(1).subscribe(onNext: { [unowned self] playlistViewModel in
            self.onSongsSubject.onNext(playlistViewModel.songs.map{(song: Song) -> SongViewModel in
                return SongViewModel(id: song.id, title: song.title, path: song.path)
            })
        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    func play(song: SongViewModel) {
        soundService.playSound(sound: SoundParams(filePath: song.path))
    }
}
