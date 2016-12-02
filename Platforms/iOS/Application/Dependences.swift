//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation
import FileKit

class Dependences {
    static var instance = Dependences()

    static var playlistService: PlaylistService = instance.internalPlaylistService
    static var storyboards: Storyboards = instance.internalStoryboards
    static var soundService: SoundService = instance.internalSoundService

    private lazy var internalPlaylistService: PlaylistService = {
        return PlaylistServiceImpl(playlistRepository: self.internalPlaylistRepository,
                sessionRepository: self.internalSessionRepository)
    }()

    private lazy var internalStoryboards: Storyboards = {
        return Storyboards()
    }()

    private lazy var internalFileRepository: FileRepository = {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let home: Path = Path(documentsPath)
        return FileRepositoryImpl(home: home)
    }()

    private lazy var internalPlaylistRepository: PlaylistRepository = {
        return PlaylistRepositoryImpl(fileRepository: self.internalFileRepository)
    }()

    private lazy var internalSessionRepository: SessionRepository = {
        return SessionRepositoryImpl(playlistRepository: self.internalPlaylistRepository)
    }()

    private lazy var internalSoundService: SoundService = {
        return SoundServiceImpl()
    }()
}
