//
//  MealCardView.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import SwiftUI
import Kingfisher

struct MealCardView: View {
    var meal: Meal
    var index: Int
    
    var topLeadingRadius: CGFloat {
        index % 2 == 0 ? 0 : 50
    }
    
    var bottomTrailingRadius: CGFloat {
        index % 2 == 0 ? 50 : 0
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(meal.name)")
                .lineLimit(3)
                .fontWeight(.light)
                .padding()
            Spacer()
            KFImage(URL(string: meal.thumbnailURL))
                .resizable()
                .scaledToFill()
                .frame(minHeight: 100)
                .clipped()
                .overlay(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .white, location: 0),
                            .init(color: .white.opacity(0.5), location: 0.25),
                            .init(color: .white.opacity(0), location: 1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        }
        .frame(height: 225)
        .clipShape(
            .rect(
                topLeadingRadius: topLeadingRadius,
                bottomLeadingRadius: 50,
                bottomTrailingRadius: bottomTrailingRadius,
                topTrailingRadius: 50
            )
        )
        .overlay {
            UnevenRoundedRectangle(
                topLeadingRadius: topLeadingRadius,
                bottomLeadingRadius: 50,
                bottomTrailingRadius: bottomTrailingRadius,
                topTrailingRadius: 50,
                style: .continuous
            )
                .stroke(.black, lineWidth: 0.5)
        }
    }
}

#Preview {
    MealCardView(meal: Meal.mockMeal, index: 0)
}
