//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift

protocol FileRepository {
    func getListFile(folder: String) -> Observable<[Song]>
}
