//
//  CategoriesView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import SwiftUI

struct CategoriesView: View {
    @Binding var categories: Categories
    @Binding var selectedItem: Category
        
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(categories) { category in
                        Text(category.name)
                            .fontWeight(.thin)
                            .foregroundColor(.black)
                            .overlay(alignment: .bottom) {
                                if category == selectedItem {
                                    Color.mint
                                        .frame(height: 1)
                                }
                            }
                            .padding()
                            .onTapGesture {
                                selectedItem = category
                            }
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top)
            }
            .padding()
            .onChange(of: selectedItem) { oldValue, newValue in
                withAnimation {
                    scrollView.scrollTo(newValue.id, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    CategoriesView(categories: .constant([Category.emptyCategory]), selectedItem: .constant(Category.emptyCategory))
}
