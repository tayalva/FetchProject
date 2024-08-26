//
//  FetchApp.swift
//  Fetch
//
//  Created by Taylor Smith on 8/23/24.
//

import SwiftUI

@main
struct FetchApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
