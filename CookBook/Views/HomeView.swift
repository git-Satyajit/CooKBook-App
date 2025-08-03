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

    var isSearching: Bool {
        !viewModel.searchText.isEmpty
    }

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
            let mocks = isSearching ? viewModel.filteredMockRecipes : Receipe.mockReceipes
            let saved = isSearching ? recipeViewModel.filteredRecipes : recipeViewModel.recipes

            ForEach(mocks, id: \.name) { mock in
                NavigationLink {
                    ReceipeDetailView(receipe: mock)
                } label: {
                    receipeRow(receipe: mock)
                }
            }

            ForEach(saved, id: \.objectID) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    recipeRowFromCoreData(recipe: recipe)
                }
            }

            if mocks.isEmpty && saved.isEmpty {
                Text("No results found.")
                    .foregroundStyle(.gray)
                    .padding()
                    .frame(maxWidth: .infinity)
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

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
               
                VStack(spacing: 0) {
                    ScrollView {
                        HStack {
                            Spacer()
                            Text("Receipes")
                                .font(.system(size: 24, weight: .bold))
                            Spacer()
                            Button {
                                viewModel.showSignoutAlert = true
                            } label: {
                                Image(systemName: "gearshape.fill")
                                    .foregroundStyle(Color.black)
                                    .font(.title3)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)

                        SearchBar(text: $viewModel.searchText)
                            .padding(.horizontal)
                            .padding(.bottom)
                            recipeGrid
                                .padding(.bottom, 60)
                    }
                    .padding(10)
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
//                    .navigationTitle("Receipes")
//                    .font(.system(size: 20))
                }

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
            .onChange(of: viewModel.searchText) {
                recipeViewModel.searchText = viewModel.searchText
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(SessionManager())
}
