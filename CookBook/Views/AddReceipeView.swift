//  AddReceipeView.swift
//  CookBook

//  Created by Satyajit Bhol on 08/07/25.

import SwiftUI
import PhotosUI
struct AddReceipeView: View {
    @State var viewModel = AddReceipeViewModel()
    @StateObject var imageLoaderViewModel = ImageLoaderViewModel()
    
    var body: some View {
        VStack(alignment: .leading){
            Text("What's New")
                .font(.system(size: 25,weight: .bold))
                .padding(.top,20)
            ZStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.primaryFormEntry)
                        .frame(height:200)
                    Image(systemName: "photo.fill")
                        .onTapGesture {
                            viewModel.showImageOption = true
                        }
                }
                if let displayReceipeImage = viewModel.displayReceipeImage {
                    displayReceipeImage
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .clipped()
                }
                    
            }
            Text("Receipe Name")
                .font(.system(size: 15,weight: .semibold))
                .padding(.top)
            TextField("Receipe Name", text: $viewModel.receipeName)
                .textFieldStyle(CapsuleTextFieldStyle())
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            Text("Preparation Time")
                .font(.system(size: 15,weight: .semibold))
                .padding(.top)
            Picker(selection: $viewModel.preparationTime) {
                ForEach(0...120,id: \.self) { time in
                    if time % 5 == 0{
                        Text("\(time) mins")
                            .tag(time)
                            .font(.system(size: 15))                    }
                    
                }
            } label: {
                Text("Prep Time")
            }
            Text("Cooking Instruction")
                .font(.system(size: 15,weight: .semibold))
                .padding(.top)
            TextEditor(text: $viewModel.instruction)
                .frame(height:150)
                .background(Color.primaryFormEntry)
                .scrollContentBackground(.hidden)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Button {
                
            } label: {
                Text("Add Receipe")
            }
            .buttonStyle(PrimaryButtonStyle())


                
                
            Spacer()
        }
        .padding(.horizontal)
        .photosPicker(isPresented: $viewModel.showLibrary, selection: $imageLoaderViewModel.imageSelection, matching: .images, photoLibrary: .shared())
        .onChange(of: imageLoaderViewModel.imageToUpload, { _, newValue in
            if let newValue = newValue {
                viewModel.displayReceipeImage = Image(uiImage: newValue)
            }
        })
        .confirmationDialog("Upload An Image To Your Receipe", isPresented: $viewModel.showImageOption, titleVisibility: .visible) {
            Button {
                viewModel.showLibrary = true
            } label: {
                Text("Upload From Library")
            }
            Button {
                viewModel.showCamera = true
            } label: {
                Text("Upload From PhotoCamera")
            }

        }
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CameraPicker { image in
                viewModel.displayReceipeImage = Image(uiImage: image)
            }
        }
    }
}

#Preview {
    AddReceipeView()
}
