//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift
import FileKit

protocol FileRepository {
    func getListFile() -> [Path]
}
