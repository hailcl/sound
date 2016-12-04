//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift

protocol SoundService {
    var onPlaying: Observable<Bool> { get }
    func playSound(sound: SoundParams)
    func pause()
    func resume()
}
