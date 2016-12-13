//
// Created by Nguyen Thanh Hai on 12/13/16.
//

import Foundation
import RxSwift
import AVFoundation
import MediaPlayer

class SoundServiceAV: NSObject, SoundService {
    let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    let nowPlayingInfoCenter:MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var audioPlayer: AVPlayer?

    override init() {
        super.init()
        do {
            try! self.audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try! self.audioSession.setActive(true)
        }
        catch let exception {

        }
    }

    var onPlaying: Observable<Bool> {
        return onPlayingSubject.asObservable()
    }
    let onPlayingSubject = BehaviorSubject<Bool>(value: false)

    func playSound(sound: SoundParams) {
        do {
            try audioPlayer = AVPlayer(url: URL(fileURLWithPath: sound.filePath))
            audioPlayer?.play()
            var nowPlayingInfo: [String: String] = [MPMediaItemPropertyTitle: sound.title]
            self.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo

            onPlayingSubject.onNext(true)
        } catch let exception{

        }
    }

    func pause() {
        if let player = audioPlayer {
            player.pause()
            onPlayingSubject.onNext(false)
        }
    }

    func resume() {
        if let player = audioPlayer {
            player.play()
            onPlayingSubject.onNext(true)
        }
    }


}
