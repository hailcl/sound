//
// Created by Nguyen Thanh Hai on 11/27/16.
//

import Foundation

class PlaylistsViewController: BaseViewController {
    var model: PlaylistsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        model = PlaylistsViewModel(playlistService: Dependences.playlistService)

        bindEvents()
        bindData()

        model.loadPlaylists()
    }

    func bindData() {

    }

    func bindEvents() {

    }

}
