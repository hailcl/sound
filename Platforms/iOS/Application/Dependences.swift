//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation

class Dependences {
    static var instance = Dependences()

    static var playlistService: PlaylistService = instance.internalPlaylistService
    static var storyboards: Storyboards = instance.internalStoryboards

    private lazy var internalPlaylistService: PlaylistService = {
        return PlaylistServiceImpl()
    }()

    private lazy var internalStoryboards: Storyboards = {
        return Storyboards()
    }()
}
