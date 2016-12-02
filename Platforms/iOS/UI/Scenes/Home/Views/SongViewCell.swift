//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import UIKit

class SongViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    var model: SongViewModel! {
        didSet {
            nameLabel.text = model.title
        }
    }
}
