//
//  MealDetailView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import SwiftUI
import Kingfisher

/// The main detail view for each recipe. Shows the title, ingredents, and instructions.
struct MealDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
        
        UINavigationBar.changeAppearance(clear: true)
    }
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(URL(string: meal.thumbnailURL))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottomTrailing) {
                        Text(meal.id)
                            .padding(.horizontal)
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(.white.opacity(0.5))
                            .font(.subheadline)
                            .padding()
                    }
                VStack(alignment: .leading) {
                    Text(meal.name)
                        .font(.largeTitle)
                    
                    IngredientsView(meal: meal)
                    
                    if let instructions = meal.instructionsArray {
                      InstructionsView(instructions: instructions)
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationTitle("")
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                BackButton(action: dismiss)
            }
        }
    }
}

struct BackButton: View {
    var action: DismissAction
    
    var body: some View {
        Image(systemName: "arrow.backward.circle.fill")
            .resizable()
            .background(.black.opacity(0.5))
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .stroke(.black)
            }
            .padding()
            .onTapGesture {
                action()
            }
    }
}

struct IngredientsView: View {
    var meal: Meal
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(Array(meal.ingredients.enumerated()), id: \.element) { index, ingredient in
                HStack {
                    Text("\(ingredient)")
                        .font(.callout)
                        .foregroundStyle(.white)
                    Spacer(minLength: 40)
                    Text("\(meal.measurements[index])")
                        .font(.callout)
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.mint)
        .cornerRadius(10)
    }
}

struct InstructionsView: View {
    var instructions: [String]
    
    var body: some View {
            VStack(alignment: .leading) {
                Text("Instructions")
                    .font(.title2)
                    .padding(.vertical)
                
                ForEach(Array(instructions.enumerated()), id: (\.element)) { index, step in
                    HStack {
                        Text("\(index + 1)")
                            .font(.callout)
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                Circle()
                                    .fill(.mint)
                            )
                        Text(step)
                            .font(.callout)
                    }
                    .padding(.vertical, 5)
                }
            }
    }
}

#Preview {
    MealDetailView(meal: Meal.mockMeal)
}

extension UINavigationBar {
    static func changeAppearance(clear: Bool) {
        let appearance = UINavigationBarAppearance()
        
        if clear {
            appearance.configureWithTransparentBackground()
        } else {
            appearance.configureWithDefaultBackground()
        }
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
