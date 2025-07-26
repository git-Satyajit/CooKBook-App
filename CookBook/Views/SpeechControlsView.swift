//
//  SpeechControlsView.swift
//  CookBook
//
//  Created by Satyajit Bhol on 24/07/25.
//

import SwiftUI

struct SpeechControlsView: View {
    @ObservedObject var speechManager: SpeechManager
    var recipeName: String
    var cookingTime: Int
    var instructions: String
    
    var body: some View {
        HStack() {
            Button {
                let textToSpeak = "\(recipeName). Cooking time \(cookingTime) minutes. Instructions: \(instructions)"
                speechManager.speak(text: textToSpeak)
            } label: {
                Label("Read", systemImage: "speaker.wave.2.fill")
                    .frame(width:100,height:20)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(speechManager.isSpeaking || speechManager.isPaused)

            if speechManager.isSpeaking || speechManager.isPaused {
                Button {
                    speechManager.pauseResume()
                } label: {
                    Image(systemName: speechManager.isPaused ? "play.fill" : "pause.fill")
                        .frame(width: 44, height: 44)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }

                Button {
                    speechManager.stop()
                } label: {
                    Image(systemName: "stop.fill")
                        .frame(width: 44, height: 44)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview { SpeechControlsView(
    speechManager: SpeechManager(),
    recipeName: "Sample Recipe",
    cookingTime: 15,
    instructions: "Mix all ingredients and bake for 30 minutes."
)
}
