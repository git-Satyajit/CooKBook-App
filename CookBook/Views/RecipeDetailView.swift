//  RecipeDetailView.swift
//  CookBook

// MARK: CoreData
import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    @State var viewModel = RecipeViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showAlert = false
    @StateObject var speechManager = SpeechManager()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button("Delete", role: .destructive) {
                    showAlert = true
                }
            }
            if let data = recipe.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
            }
            HStack {
                Text(recipe.name ?? "")
                    .font(.system(size: 22, weight: .semibold))
                    .lineLimit(1)
                    .layoutPriority(1)
                Spacer()
                Image(systemName: "clock.fill")
                    .font(.system(size: 15))
                Text("\(recipe.preparationTime) mins")
            }
            .padding(.top)
            .padding(.horizontal)
            
            SpeechControlsView(
                speechManager: speechManager,
                recipeName: recipe.name ?? "",
                cookingTime: Int(recipe.preparationTime),
                instructions: recipe.instruction ?? ""
            )
        }
        .padding(.horizontal)
        .padding(.top, 10)
        .alert("Do you want to delete Receipe", isPresented: $showAlert) {
            Button("Ok", role: .destructive) {
                viewModel.deleteRecipe(recipe)
                print("Recipe Deletion Button Tapped")
                dismiss()
            }
            Button("Cancel", role: .cancel) {
                
            }
            
        }
        
        ScrollView {
            Text(recipe.instruction ?? "")
                .font(.system(size: 15))
                .padding(.top, 10)
                .padding(.horizontal)
        }
        
        Spacer()
    }
}

#Preview {
    // Provide a mock recipe instance for preview
    let context = PersistenceController.shared.container.viewContext
    let sample = Recipe(context: context)
    sample.name = "Preview Pasta"
    sample.instruction = "Boil pasta, add sauce, serve hot."
    sample.preparationTime = 15
    sample.imageData = UIImage(named: "placeholder")?.jpegData(compressionQuality: 1.0)
    
    return RecipeDetailView(recipe: sample)
}

