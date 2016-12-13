//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import RxSwift
import CocoaLumberjackSwift
import MediaPlayer

class HomeViewModel: BaseViewModel {
    var playlistService: PlaylistService
    let commandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
    var soundService: SoundService
    var paused = Property<Bool>(true)
    var currentSong = Property<SongViewModel?>(nil)
    var onPlaying: Observable<Bool>
    var onPlaylist: Observable<PlaylistViewModel> {
        return onPlaylistSubject.asObservable().shareReplay(1)
    }
    var onSongs: Observable<[SongViewModel]> { return onSongsSubject.asObservable() }

    let onPlaylistSubject = PublishSubject<PlaylistViewModel>()
    let onSongsSubject = BehaviorSubject<[SongViewModel]>(value: [])

    init (playlistService: PlaylistService, soundService: SoundService) {
        self.playlistService = playlistService
        self.soundService = soundService
        self.onPlaying = soundService.onPlaying
        super.init()
        _ = soundService.onPlaying.subscribe(onNext: { [unowned self] playing in
            if self.paused.value == false && playing == false {
                self.next()
            }
        }, onError: nil, onCompleted: nil, onDisposed: nil)

        self.commandCenter.playCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.resume()
            return .success
        }

        self.commandCenter.pauseCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.pause()
            return .success
        }

        self.commandCenter.nextTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.next()
            return .success
        }

        self.commandCenter.previousTrackCommand.addTarget { [weak self] event -> MPRemoteCommandHandlerStatus in
            guard let sself = self else { return .commandFailed }
            sself.previous()
            return .success
        }
    }

    func pause() {
        paused.set(value: true)
        soundService.pause()
    }

    func resume() {
        paused.set(value: false)
        soundService.resume()
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
        currentSong.set(value: song)
        paused.value = false
        soundService.playSound(sound: SoundParams(filePath: song.path, title: song.title))
    }

    func next() {
        guard let song = currentSong.value else {
            return
        }
        _ = playlistService.onCurrentPlaylist.take(1).subscribe(onNext: { [unowned self] playlist in
            let playlistViewModel = PlaylistViewModel(id: playlist.id, title: playlist.title,
                    songs: playlist.songs.map{ (song: Song) -> SongViewModel in
                        return SongViewModel(id: song.id, title: song.title, path: song.path)
                    })
            let songs:[SongViewModel] = playlistViewModel.songs
            let index = songs.index{ $0.id == song.id}
            var songViewModel: SongViewModel?

            if index == (songs.count - 1) {
                songViewModel = songs[0]
            }
            else {
                songViewModel = songs[index! + 1]
            }

            self.play(song: songViewModel!)

        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }

    func previous() {
        guard let song = currentSong.value else {
            return
        }
        _ = playlistService.onCurrentPlaylist.take(1).subscribe(onNext: { [unowned self] playlist in
            let playlistViewModel = PlaylistViewModel(id: playlist.id, title: playlist.title,
                    songs: playlist.songs.map{ (song: Song) -> SongViewModel in
                        return SongViewModel(id: song.id, title: song.title, path: song.path)
                    })
            let songs:[SongViewModel] = playlistViewModel.songs
            let index = songs.index{ $0.id == song.id}
            var songViewModel: SongViewModel?

            if index == 0 {
                songViewModel = songs.last!
            }
            else {
                songViewModel = songs[index! - 1]
            }

            self.play(song: songViewModel!)

        }, onError: nil, onCompleted: nil, onDisposed: nil)
    }
}
