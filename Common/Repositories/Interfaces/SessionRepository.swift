//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift

protocol SessionRepository {
    var onCurrentPlaylist: Observable<Playlist> { get }
    func store(playlist: Playlist)
}
