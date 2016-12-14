//
// Created by Nguyen Thanh Hai on 11/25/16.
//

import UIKit
import DrawerController

class MainViewController: DrawerController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    init() {

        let storyboard = Dependences.storyboards.main
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let centerVC = UINavigationController(rootViewController: home)

        let playlistsVC = storyboard.instantiateViewController(withIdentifier: "PlaylistsViewController") as! PlaylistsViewController

        super.init(centerViewController: centerVC, leftDrawerViewController: playlistsVC,
                rightDrawerViewController:nil)

        self.openDrawerGestureModeMask = [OpenDrawerGestureMode.all]
        self.closeDrawerGestureModeMask = [CloseDrawerGestureMode.all]
    }
}
