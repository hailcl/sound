//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import UIKit

class HomeViewDataSource: NSObject {
    var songs: [SongViewModel] = []

    func loadSongs(songs: [SongViewModel]) {
        self.songs = songs
    }
}

extension HomeViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongViewCell", for: indexPath) as! SongViewCell
        cell.model = songs[indexPath.row]

        return cell
    }

}

extension HomeViewDataSource: UITableViewDelegate {

}
