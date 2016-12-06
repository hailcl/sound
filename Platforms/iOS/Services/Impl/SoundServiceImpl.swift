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

    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch  let exception {
            debugPrint(exception)
        }

        let audioSession = AVAudioSession.sharedInstance()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleInterruption(notification:)),
                name: NSNotification.Name.AVAudioSessionInterruption,
                object: nil)

        do {
            try audioSession.setActive(true)
        } catch _ {
        }
    }

    @objc func handleInterruption(notification: NSNotification){
        let interruptionTypeAsObject =
        notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber

        let interruptionType = AVAudioSessionInterruptionType(rawValue:
        interruptionTypeAsObject.uintValue)

        if let type = interruptionType{
            switch type {
                case .ended: break
                case .began:
                    if let player = player {
                        player.pause()
                    }
                break
            }
        }

        onPlayingSubject.onNext(false)

    }
    
    func playSound(sound: SoundParams) {
        do {
            if let player = player {
                player.stop()
                try player.replace(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                player.completionHandler = { [unowned self] _ in
                    self.onPlayingSubject.onNext(false)
                }
                AKSettings.playbackWhileMuted = true
                AudioKit.output = player
                if player.isPlaying == false {
                    player.start()
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
            onPlayingSubject.onNext(false)
        }
    }

    func resume() {
        if let player = player {
            do {
                try player.reloadFile()
                player.start()
                onPlayingSubject.onNext(true)
            } catch let error {
                debugPrint(error)
            }
        }
    }


}
