//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift
import FileKit

class FileRepositoryImpl: FileRepository {
    var home: Path

    init (home: Path) {
        self.home = home
        debugPrint(home)
    }

    func getListFile() -> [Path] {
        return self.home.children()
    }
}
