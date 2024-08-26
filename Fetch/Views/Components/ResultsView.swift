//
//  ResultsView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 0)
    ]
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            }
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(Array(viewModel.currentlyShowingMeals.enumerated()), id: \.element) { index, meal in
                        MealCardView(meal: meal, index: index)
                            .onTapGesture {
                                Task {
                                    await viewModel.navigateToDetail(for: meal)
                                }
                            }
                    }
                }
            }
            .opacity(viewModel.listOpacity)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ResultsView(viewModel: HomeViewModel())
}
