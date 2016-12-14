//
// Created by Nguyen Thanh Hai on 12/13/16.
//

import Foundation
import RxSwift
import AVFoundation
import MediaPlayer

class SoundServiceAV: NSObject, SoundService, AVAudioPlayerDelegate {
    let audioSession: AVAudioSession = AVAudioSession.sharedInstance()
    var audioPlayer: AVAudioPlayer?

    override init() {
        super.init()
        do {
            try! self.audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try! self.audioSession.setActive(true)
        }
        catch let _ {

        }
    }

    var onPlaying: Observable<Bool> {
        return onPlayingSubject.asObservable()
    }
    let onPlayingSubject = BehaviorSubject<Bool>(value: false)

    var onDurration: Observable<TimeInterval> {
        return onDurrationSubject.asObservable()
    }
    let onDurrationSubject = BehaviorSubject<TimeInterval>(value: 20.0)

    var onCurrentSound: Observable<SoundParams?> {
        return onCurrentSoundSubject.asObservable()
    }

    let onCurrentSoundSubject = BehaviorSubject<SoundParams?>(value: nil)

    func playSound(sound: SoundParams) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound.filePath))
            audioPlayer?.play()
            audioPlayer?.delegate = self
            onDurrationSubject.onNext(audioPlayer != nil ? audioPlayer!.duration : 0.0)
            onCurrentSoundSubject.onNext(sound)
            onPlayingSubject.onNext(true)
        } catch let _{

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

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onCurrentSoundSubject.onNext(nil)
        onPlayingSubject.onNext(false)
    }

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        onCurrentSoundSubject.onNext(nil)
        onPlayingSubject.onNext(false)
    }

    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        onCurrentSoundSubject.onNext(nil)
        onPlayingSubject.onNext(false)
    }

    func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int) {
        onCurrentSoundSubject.onNext(nil)
        onPlayingSubject.onNext(false)
    }

    func playAt(time: TimeInterval) {
        if let player = audioPlayer {
            player.currentTime = time
        }
    }

}
