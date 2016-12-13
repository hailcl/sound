//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import UIKit
import RxSwift
import CocoaLumberjackSwift
import AVFoundation
import MediaPlayer

class HomeViewController: BaseViewController {
    var model: HomeViewModel!
    var dataSource: HomeViewDataSource!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = HomeViewDataSource()
        model = HomeViewModel(playlistService: Dependences.playlistService, soundService: Dependences.soundService)

        tableView.dataSource = dataSource
        tableView.delegate = dataSource

        bindData()

        bindEvents()

        model.loadPlaylist()

        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
        } catch {
        }
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
        disposeBag.insert(
                dataSource.onSelectSong.subscribe(onNext: { [unowned self] songViewModel in
                    self.model.play(song: songViewModel)
                }, onError: nil, onCompleted: nil, onDisposed: nil))
        disposeBag.insert(
                model.onPlaying.subscribe(onNext: { [unowned self] playing in
                    if playing == true {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pause", style: .plain, target: self, action: #selector(self.pause))
                    } else {
                        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Resume", style: .plain, target: self, action: #selector(self.resume))
                    }
                }, onError: nil, onCompleted: nil, onDisposed: nil)
                )
    }

    func pause() {
        model.pause()
    }

    func resume() {
        model.resume()
    }
}
