//
// Created by Nguyen Thanh Hai on 11/23/16.
//

import UIKit

class BootstrapViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = Dependences.storyboards.main
        let home = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        viewControllers = [home]
    }

}
