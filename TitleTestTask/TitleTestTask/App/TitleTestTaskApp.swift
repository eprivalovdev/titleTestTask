//
//  TitleTestTaskApp.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import SwiftUI
import ComposableArchitecture

@main
struct TitleTestTaskApp: App {
	
	@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
	
	var body: some Scene {
		WindowGroup {
			SurveyFlowView(
				store: Store(
					initialState: SurveyFlowFeature.State(),
					reducer: { SurveyFlowFeature() }
				)
			)
			.titleNavigationBar()
		}
	}
}
