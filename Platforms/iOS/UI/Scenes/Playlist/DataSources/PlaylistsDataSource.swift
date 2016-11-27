//
// Created by Nguyen Thanh Hai on 11/27/16.
//

import Foundation
import UIKit

class PlaylistsDataSource: NSObject {
    var playlists:[PlaylistViewModel] = []

    func load(playlists: [PlaylistViewModel]) {
        self.playlists = playlists
    }
}

extension PlaylistsDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistViewCell", for: indexPath)
        as! PlaylistViewCell
        cell.model = playlists[indexPath.row]

        return cell
    }

}

extension PlaylistsDataSource: UITableViewDelegate {

}
