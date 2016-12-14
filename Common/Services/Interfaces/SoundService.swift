//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import RxSwift

protocol SoundService {
    var onPlaying: Observable<Bool> { get }
    var onDurration: Observable<TimeInterval> { get }
    var onCurrentSound: Observable<SoundParams?> { get }
    func playSound(sound: SoundParams)
    func pause()
    func resume()
    func playAt(time: TimeInterval)
}
