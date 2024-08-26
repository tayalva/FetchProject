//
//  HomeViewModel.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    let services = APIManager()
   
    @Published var isLoading: Bool = false
    @Published var categories: Categories = []
    @Published var currentlyShowingMeals: Meals = []
    @Published var selectedCategory: Category = .emptyCategory
    @Published var listOpacity: CGFloat = 0
    @Published var searchText = ""
    @Published var showError = false
    @Published var navPath = NavigationPath()
    
    var error: MealsError?
    private var subscriptions = Set<AnyCancellable>()
    
    private var isSearching: Bool {
        !searchText.isEmpty
    }
    
    init() {
        Task {
            await setupCategories()
        }
        
        $selectedCategory
            .sink { [weak self] category in
                if
                    category != self?.selectedCategory,
                   self?.isSearching == false
                {
                    // Hack to allow for Category animation to complete before fetching.
                    // There are better ways to do this if I had more time.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    Task {
                            self?.isLoading = true
                            await self?.showMealsByCategory(category)
                            self?.isLoading = false
                        }
                    }
                }
            }
            .store(in: &subscriptions)
        
        $isLoading
            .sink { [weak self] isLoading in
                self?.showList(!isLoading)
            }
            .store(in: &subscriptions)
    }
    
    func showList(_ show: Bool) {
        listOpacity = 0
        
        if show {
            withAnimation {
                listOpacity = 1
            }
        }
    }
    
    func setupCategories() async {
        await getAllCategires()
        selectedCategory = categories.first { $0.name == "Dessert" } ?? Category.emptyCategory
    }
    
    func clearSearch() {
        searchText.removeAll()
    }
    
    func getAllCategires() async {
        do {
            let rawCategories = try await services.fetchAllCategories()
            categories = rawCategories.sorted { $0.name < $1.name }
        } catch {
            showError(error)
        }
    }
    
    func showMealsByCategory(_ category: Category) async {
        do {
            let meals = try await services.fetchMealsByCategory(category)
                currentlyShowingMeals = meals.sorted { $0.name < $1.name }
        } catch {
            showError(error)
        }
    }
    
    func searchForMeal() async {
        await fetchMealById(searchText, isSearching: true)
    }
    
    @discardableResult
    func fetchMealById(_ id: String, isSearching: Bool = false) async -> Meal? {
        do {
            let meal = try await services.fetchMealById(id)
            
            if isSearching {
                currentlyShowingMeals = [meal]
            }
            
            if let categoryName = meal.category {
                selectedCategory = categories.first { $0.name == categoryName } ?? Category.emptyCategory
            }
            
            clearSearch()
            return meal
        } catch {
            showError(error)
        }
        
        return nil
    }
    
    func navigateToDetail(for meal: Meal) async {
        if let mealDetail = await fetchMealById(meal.id) {
            navPath.append(mealDetail)
        }
    }
    
    func showError(_ error: Error) {
        if let error = error as? MealsError {
            self.error = error
            showError = true
        }
    }
}
