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
    }

    func getListFile(folder: String) -> Observable<[Song]> {
        return Observable.just([])
    }

}
