//
// Created by Nguyen Thanh Hai on 11/27/16.
//

import Foundation
import RxSwift

class PlaylistsViewModel {
    let playlistService: PlaylistService

    init(playlistService: PlaylistService) {
        self.playlistService = playlistService
    }

    func loadPlaylists() {
    }
}
