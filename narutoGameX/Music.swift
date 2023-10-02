import AVFoundation
import UIKit

class Music {
    
    var backGroundAudioPlayer: AVAudioPlayer?
    var actionAudioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        guard let soundURL = Bundle.main.url(forResource: "battlesong", withExtension: "mp3") else {
            print("Arquivo de som de fundo não encontrado.")
            return
        }
        do {
            backGroundAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            backGroundAudioPlayer?.numberOfLoops = -1
            backGroundAudioPlayer?.prepareToPlay()
            backGroundAudioPlayer?.play()
        } catch {
            print("Erro ao reproduzir o som de fundo: \(error.localizedDescription)")
        }
    }
    
    func playActionSound(soundFileName: String) {
        guard let soundURL = Bundle.main.url(forResource: soundFileName, withExtension: "mp3") else {
            print("Arquivo de som não encontrado: \(soundFileName)")
            return
        }
        do {
            actionAudioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            actionAudioPlayer?.play()
        } catch {
            print("Erro ao reproduzir o som da transformação: \(error.localizedDescription)")
        }
    }
}
