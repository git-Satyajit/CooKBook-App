//
//  HomeView.swift
//  CookBook
//

import SwiftUI

struct HomeView: View {
    @Environment(SessionManager.self) var sessionManager: SessionManager
    @State var viewModel = HomeViewModel()
    let spacing:CGFloat = 5
    let padding:CGFloat = 5
    var itemWidth:CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - (spacing * 2)-(padding * 2)) / 3
    }
    var itemHeight: CGFloat {
        return CGFloat(1.5) * itemWidth
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    fileprivate func ReceipeRow(receipe: Receipe) -> some   View {
        
        VStack(alignment:.leading) {
            Image(receipe.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: itemWidth,height: itemHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .clipped()
            Text(receipe.name)
                .lineLimit(1)
                .font(.system(size:15,weight:.semibold))
                .foregroundStyle(Color.black)
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns,spacing: spacing){
                        ForEach(0...6,id: \.self) { index in
                            NavigationLink {
                                ReceipeDetailView(receipe: Receipe.mockReceipes[index])
                            } label: {
                                ReceipeRow(receipe: Receipe.mockReceipes[index])
                            }
                            
                            
                        }
                        //                    ReceipeRow(receipe: Receipe.mockReceipes[0])
                        //                    ReceipeRow(receipe: Receipe.mockReceipes[1])
                        //                    ReceipeRow(receipe: Receipe.mockReceipes[2])
                    }
                    .padding(.horizontal,padding)
                    Spacer()
                    Button {
                        viewModel.showAddReceipeView = true
                    } label: {
                        Text("Add Receipe")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .padding(.horizontal)
                    
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.showSignoutAlert = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .foregroundStyle(Color.black)
                        }
                        
                    }
                }
                .alert("Are You sure to logout ?", isPresented: $viewModel.showSignoutAlert) {
                    Button("Sign out", role:.destructive) {
                        if viewModel.signOut() {
                            sessionManager.sessionState = .loggedout
                        }
                        else {
                            sessionManager.sessionState = .loggedIn
                        }
                    }
                    Button("Cancel", role: .cancel) {
                    }
                }
                .navigationTitle("CookBook")
                .font(.system(size: 20)
                      
                )
            }
            .sheet(isPresented: $viewModel.showAddReceipeView) {
                AddReceipeView()
            }
            
        }
        
        
    }
}
    


#Preview {
    HomeView()
        .environment(SessionManager())
}


