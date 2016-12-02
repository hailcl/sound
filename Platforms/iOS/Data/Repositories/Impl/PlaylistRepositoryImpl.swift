//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import FileKit

class PlaylistRepositoryImpl: PlaylistRepository {
    var fileRepository: FileRepository

    init(fileRepository: FileRepository) {
        self.fileRepository = fileRepository
    }

    func defaultPlaylist() -> Playlist {
        return Playlist(id: "default", title: "Default",
                songs: fileRepository.getListFile().map{ (path:Path)-> Song in
                    return Song(id: path.fileName, title: path.fileName, path: path.standardRawValue)
                })
    }

}
