//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import Foundation

class HomeViewController: BaseViewController {
    var model: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        model = HomeViewModel()

        bindData()

        bindEvents()

        model.loadPlaylist()
    }

    func bindData() {

    }

    func bindEvents() {

    }

}
