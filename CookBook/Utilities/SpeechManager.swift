//  SpeechManager.swift
//  CookBook
//  Created by Satyajit Bhol on 23/07/25.


import Foundation
import AVFoundation
class SpeechManager:NSObject,ObservableObject,AVSpeechSynthesizerDelegate {
    private let  synthesizer = AVSpeechSynthesizer()
    @Published var isSpeaking = false
    @Published var isPaused = false
    override init() {
        super.init()
        synthesizer.delegate = self
        setupAudioSession()
    }
    func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .duckOthers)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch {
            print("Failed to setup Audio Session\(error.localizedDescription)")
        }
    }
    func speak(text:String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5 // Slower rate for cooking instructions
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        synthesizer.speak(utterance)
        isSpeaking = true
        isPaused = false
    }
    func pauseResume() {
          if synthesizer.isSpeaking {
              if synthesizer.isPaused {
                  synthesizer.continueSpeaking()
                  isPaused = false
              } else {
                  synthesizer.pauseSpeaking(at: .immediate)
                  isPaused = true
              }
          }
      }
    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isPaused = false
        isSpeaking = false
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isPaused = false
            self.isSpeaking = true
        }
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isPaused = false
            self.isSpeaking = false
        }
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            self.isPaused = true
            self.isSpeaking = false
        }
    }
    
}
