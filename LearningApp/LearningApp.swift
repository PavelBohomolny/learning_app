//
//  LearningApp.swift
//  LearningApp
//
//  Created by Pavel Bohomolnyi on 03/08/2022.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
