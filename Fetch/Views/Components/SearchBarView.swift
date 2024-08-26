//
//  SearchBarView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: HomeViewModel
    @FocusState var searchIsFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Search by ID", text: $viewModel.searchText)
                .focused($searchIsFocused)
                .keyboardType(.numberPad)
                .onSubmit {
                    Task {
                        await viewModel.searchForMeal()
                    }
                }
            
                Button(action: {
                    Task {
                        searchIsFocused = false
                        await viewModel.searchForMeal()
                    }
                }, label: {
                    Text("Search")
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                })
                .background(
                    .mint
                )
                .cornerRadius(20)
                .scaleEffect(searchIsFocused ? 1 : 0.0)
                .animation(.snappy(duration: 0.2), value: searchIsFocused)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(viewModel: HomeViewModel())
}
