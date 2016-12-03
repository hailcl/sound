//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import AudioKit
import AVFoundation

class SoundServiceImpl: SoundService {
    var player: AKAudioPlayer?

    func playSound(sound: SoundParams) {
        do {
            if let player = player {
                if player.isPlaying {
                    player.stop()
                    try player.replace(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                    player.play()
                }
            }
            else {
                player = try AKAudioPlayer(file: AKAudioFile(forReading: URL(fileURLWithPath: sound.filePath)))
                AudioKit.output = player
                AudioKit.start()

                player!.play()
            }

        } catch let error {
            print(error.localizedDescription)
        }
    }
}
