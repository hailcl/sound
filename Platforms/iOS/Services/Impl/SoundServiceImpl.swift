//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import AudioKit
import RxSwift
import AVFoundation
import MediaPlayer

class SoundServiceImpl: SoundService {
    var player: AKAudioPlayer?
    var onPlaying: Observable<Bool> {
        return onPlayingSubject.asObservable()
    }
    let onPlayingSubject = BehaviorSubject<Bool>(value: false)
    
    func playSound(sound: SoundParams) {
        do {
            if let player = player {
                try player.replace(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                player.completionHandler = { [unowned self] _ in
                    self.onPlayingSubject.onNext(false)
                }
                AKSettings.playbackWhileMuted = true
                AudioKit.start()
                if player.isPlaying == false {
                    player.play()
                }
                onPlayingSubject.onNext(true)
            }
            else {
                player = try AKAudioPlayer(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                player!.completionHandler = { [unowned self] _ in
                    self.onPlayingSubject.onNext(false)
                }
                AKSettings.playbackWhileMuted = true
                AudioKit.output = player
                AKSettings.disableAVAudioSessionCategoryManagement = false
                try AKSettings.setSession(category: AKSettings.SessionCategory.playback)
                
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
            player.pause()
        }
    }

    func resume() {
        if let player = player {
            do {
                try player.reloadFile()
                player.start()
            } catch let error {
                debugPrint(error)
            }
        }
    }


}
