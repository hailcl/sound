//
// Created by Nguyen Thanh Hai on 12/2/16.
//

import Foundation
import AudioKit
import AVFoundation

class SoundServiceImpl: SoundService {
    var player: AVAudioPlayer?

    func playSound(sound: SoundParams) {
        debugPrint(sound.filePath)
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound.filePath))
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
