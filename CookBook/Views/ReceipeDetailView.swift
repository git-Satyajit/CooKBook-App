//  ReceipeDetailView.swift
//  CookBook

import SwiftUI

struct ReceipeDetailView: View {
    let receipe: Receipe
    @StateObject var speechManager = SpeechManager()
    var body: some View {
        VStack {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 300)
                .clipped()
            HStack {
                Text(receipe.name)
                    .font(.system(size:22,weight:.semibold))
                Spacer()
                Image(systemName: "clock.fill")
                    .font(.system(size: 15))
                Text("\(receipe.time) mins")
            }
            .padding(.top)
            .padding(.horizontal)
            //
            SpeechControlsView(speechManager: speechManager, recipeName: receipe.name, cookingTime: receipe.time, instructions: receipe.instructions)
        }
        .padding(.horizontal)
        .padding(.top, 10)
        ScrollView {
            Text("\(receipe.instructions)")
                .font(.system(size: 15))
                .padding(.top,10)
                .padding(.horizontal)
        }
                Spacer()
            }
        }

#Preview {
    ReceipeDetailView(receipe: Receipe.mockReceipes[0])
}
