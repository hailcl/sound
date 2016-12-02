//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation

class PlaylistRepositoryImpl: PlaylistRepository {
    var fileRepository: FileRepository

    init(fileRepository: FileRepository) {
        self.fileRepository = fileRepository
    }

    func defaultPlaylist() -> Playlist {
        return Playlist(id: "default", title: "Default", songs: fileRepository.getListFile().map{ Path -> Song in return Song() })
    }

}
