//
// Created by Nguyen Thanh Hai on 11/27/16.
//

import Foundation

class PlaylistViewModel {
    var id: String
    var title: String
    var songs:[SongViewModel]

    init(id: String, title: String, songs:[SongViewModel]) {
        self.id = id
        self.title = title
        self.songs = songs
    }
}
