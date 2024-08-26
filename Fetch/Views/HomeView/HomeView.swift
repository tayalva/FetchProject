//
//  HomeView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import SwiftUI
import Kingfisher

/// Main view that where the user can search by id, select a category and select a recipe for more info.
struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @FocusState var searchIsFocused: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navPath) {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                    .onTapGesture {
                        searchIsFocused = false
                    }
            VStack {
                SearchBarView(
                    viewModel: viewModel,
                    searchIsFocused: _searchIsFocused
                )
                    .focused($searchIsFocused)
                CategoriesView(
                    categories: $viewModel.categories,
                    selectedItem: $viewModel.selectedCategory
                )
                
                ResultsView(viewModel: viewModel)
                    .onTapGesture {
                        searchIsFocused = false
                    }
            }
            .navigationDestination(for: Meal.self) { meal in
                MealDetailView(meal: meal)
            }
            .alert(isPresented: $viewModel.showError, withError: viewModel.error)
        }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
