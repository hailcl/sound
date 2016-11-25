//
// Created by Nguyen Thanh Hai on 11/23/16.
//

import UIKit

class Navigator {
    var storyboard: UIStoryboard
    var navigationController: UINavigationController

    init (storyboard: UIStoryboard, navigationController: UINavigationController) {
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
}
