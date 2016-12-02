//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import UIKit
import RxSwift
import CocoaLumberjackSwift

class HomeViewController: BaseViewController {
    var model: HomeViewModel!
    var dataSource: HomeViewDataSource!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = HomeViewDataSource()
        model = HomeViewModel(playlistService: Dependences.playlistService)

        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        bindData()

        bindEvents()

        model.loadPlaylist()
    }

    func bindData() {
        disposeBag.insert(
                model.onPlaylistSubject.subscribe(onNext: { [unowned self] playlistViewModel in
                    self.title = playlistViewModel.title
                    self.model.loadSongs()
                }, onError: nil, onCompleted: nil, onDisposed: nil))
        disposeBag.insert(
                model.onSongs.subscribe(onNext: { [unowned self] songViewModels in
                    self.dataSource.loadSongs(songs: songViewModels)
                    self.tableView.reloadData()
                }, onError: nil, onCompleted: nil, onDisposed: nil))
    }

    func bindEvents() {

    }

}
