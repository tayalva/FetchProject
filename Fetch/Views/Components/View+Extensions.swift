//
//  View+Extensions.swift
//  Fetch
//
//  Created by Taylor Smith on 8/26/24.
//

import SwiftUI

extension View {
    func alert(
        isPresented: Binding<Bool>,
        withError error: MealsError?
    ) -> some View {
        return alert(
            error?.title ?? "",
            isPresented: isPresented,
            actions: {
                Button("Ok") {}
            }, message: {
                Text(error?.userMessage ?? "")
            }
        )
    }
}
