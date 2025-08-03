//  RecipeViewModel.swift
//  CookBook
// CoreData
import Foundation
import CoreData
import UIKit
import SwiftUI
@Observable
class RecipeViewModel {
    var recipes: [Recipe] = []
    var searchText: String = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                ($0.name ?? "").localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    private let context = PersistenceController.shared.container.viewContext

    // Save
    func saveRecipe(name: String, instruction: String, prepTime: Int, image: UIImage?) {
        let newRecipe = Recipe(context: context)
        newRecipe.name = name
        newRecipe.instruction = instruction
        newRecipe.preparationTime = Int16(prepTime)
        newRecipe.imageData = image?.jpegData(compressionQuality: 0.9)

        do {
            try context.save()
            fetchRecipes()
        } catch {
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }

    // Fetch
    func fetchRecipes() {
        let request: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            recipes = try context.fetch(request)
        } catch {
            print("Error fetching recipes: \(error.localizedDescription)")
        }
    }

    // Update
    func updateRecipe(_ recipe: Recipe, name: String, instruction: String, prepTime: Int, image: UIImage? = nil) {
        recipe.name = name
        recipe.instruction = instruction
        recipe.preparationTime = Int16(prepTime)
        if let img = image {
            recipe.imageData = img.jpegData(compressionQuality: 0.9)
        }

        do {
            try context.save()
            fetchRecipes()
        } catch {
            print("Error updating recipe: \(error.localizedDescription)")
        }
    }

    // Delete
    func deleteRecipe(_ recipe: Recipe) {
        context.delete(recipe)
        do {
            try context.save()
            fetchRecipes()
        } catch {
            print("Error deleting recipe: \(error.localizedDescription)")
        }
    }
}
