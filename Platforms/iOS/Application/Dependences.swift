//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation

class Dependences {
    static var instance = Dependences()

    static var playlistService: PlaylistService = instance.internalPlaylistService


    private lazy var internalPlaylistService: PlaylistService = {
        return PlaylistServiceImpl()
    }()
}
