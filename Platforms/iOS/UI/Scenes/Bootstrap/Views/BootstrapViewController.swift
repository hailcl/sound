//
// Created by Nguyen Thanh Hai on 11/23/16.
//

import UIKit

class BootstrapViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()

        customeAppearance()

        viewControllers = [MainViewController()]
    }

    private func customeAppearance() {
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName :
                                                            UIFont(name: Constants.Fonts.TitleFontName.rawValue, size: 24)!,
                                                            NSForegroundColorAttributeName :
                                                            Constants.Colors.SecondaryColor]
        UINavigationBar.appearance().tintColor = Constants.Colors.MainBackgroundColor
        UINavigationBar.appearance().barTintColor = Constants.Colors.MainBackgroundColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Constants.Colors.MainBackgroundColor
        UINavigationBar.appearance().shadowImage = UIImage()

        UINavigationBar.appearance().backIndicatorImage = UIImage(asset: Asset.Icon_Nav_Back)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = UIImage(asset: Asset.Icon_Nav_Back)
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60),
                                                                          for:UIBarMetrics.default)
    }

}
