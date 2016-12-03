//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import AudioKit
import RxSwift

class SoundServiceImpl: SoundService {
    var player: AKAudioPlayer?
    var onPlaying: Observable<Bool> {
        return onPlayingSubject.asObservable()
    }
    let onPlayingSubject = BehaviorSubject<Bool>(value: false)

    func playSound(sound: SoundParams) {
        do {
            if let player = player {
                player.stop()
                try player.replace(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                player.completionHandler = { [unowned self] _ in self.onPlayingSubject.onNext(false) }
                player.play()
                onPlayingSubject.onNext(true)
            }
            else {
                player = try AKAudioPlayer(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                player!.completionHandler = { [unowned self] _ in self.onPlayingSubject.onNext(false) }
                AudioKit.output = player
                AudioKit.start()
                player!.play()
                onPlayingSubject.onNext(true)
            }

        } catch let error {
            print(error.localizedDescription)
            onPlayingSubject.onNext(false)
        }
    }

    func pause() {
        if let player = player {
            player.stop()
        }
    }

}
