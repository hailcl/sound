//
// Created by Nguyen Thanh Hai on 11/24/16.
//

import Foundation

class Playlist {
    var id: String
    var title: String
    var songs:[Song]

    init(id: String, title: String,songs:[Song]) {
        self.id = id
        self.title = title
        self.songs = songs
    }
}
