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
        let attributes = [NSFontAttributeName :
            UIFont(name: Constants.Fonts.TitleFontName.rawValue, size: 24)!,
                          NSForegroundColorAttributeName :
                            Constants.Colors.SecondaryColor]
        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().tintColor = Constants.Colors.SecondaryColor
        UINavigationBar.appearance().barTintColor = Constants.Colors.MainBackgroundColor
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = Constants.Colors.MainBackgroundColor
        UINavigationBar.appearance().shadowImage = UIImage()

        let image = UIImage(asset: Asset.Icon_Nav_Back)
        UINavigationBar.appearance().backIndicatorImage = image
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = image
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60),
                                                                          for:UIBarMetrics.default)
    }

}

extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
