//
//  HomeView.swift
//  CookBook
//
import SwiftUI

struct HomeView: View {
    @Environment(SessionManager.self) var sessionManager: SessionManager
    @State var viewModel = HomeViewModel()
    @State var recipeViewModel = RecipeViewModel()

    let spacing: CGFloat = 5
    let padding: CGFloat = 5

    var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (spacing * 2) - (padding * 2)) / 3
    }

    var itemHeight: CGFloat {
        return CGFloat(1.5) * itemWidth
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    // MARK: - Subviews
    
    @ViewBuilder
    private func receipeRow(receipe: Receipe) -> some View {
        VStack(alignment: .leading) {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth, height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            
            Text(receipe.name)
                .lineLimit(1)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.black)
        }
    }

    @ViewBuilder
    private func recipeRowFromCoreData(recipe: Recipe) -> some View {
        VStack(alignment: .leading) {
            if let data = recipe.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: itemWidth, height: itemHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .clipped()
            }
            
            Text(recipe.name ?? "")
                .lineLimit(1)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(Color.black)
        }
    }
    
    @ViewBuilder
    private var recipeGrid: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            // Static 7 mock recipes
            ForEach(Receipe.mockReceipes, id: \.name) { mock in
                NavigationLink {
                    ReceipeDetailView(receipe: mock)
                } label: {
                    receipeRow(receipe: mock)
                }
            }

            // CoreData recipes
            ForEach(recipeViewModel.recipes, id: \.objectID) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    recipeRowFromCoreData(recipe: recipe)
                }
            }
        }
        .padding(.horizontal, padding)
    }
    
    @ViewBuilder
    private var addRecipeButton: some View {
        Button {
            viewModel.showAddReceipeView = true
        } label: {
            Text("Add Receipe")
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding(.horizontal)
    }
    
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                viewModel.showSignoutAlert = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(Color.black)
            }
        }
    }

    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack {
                    ScrollView {
                        recipeGrid
                            .padding(.bottom, 60) // add padding so grid doesn't hide behind button
                    }
                    .toolbar {
                        toolbarContent
                    }
                    .alert("Are You sure to logout ?", isPresented: $viewModel.showSignoutAlert) {
                        Button("Sign out", role: .destructive) {
                            if viewModel.signOut() {
                                sessionManager.sessionState = .loggedout
                            } else {
                                sessionManager.sessionState = .loggedIn
                            }
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                    .navigationTitle("Receipes")
                    .font(.system(size: 20))
                }

                // Fixed button
                addRecipeButton
                    .padding(.bottom, 10)
            }
            .sheet(isPresented: $viewModel.showAddReceipeView) {
                AddReceipeView()
                    .environment(recipeViewModel)
            }
            .onAppear {
                recipeViewModel.fetchRecipes()
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(SessionManager())
}

