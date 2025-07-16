//
//  SurveyFlowView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct SurveyFlowView: View {
	let store: StoreOf<SurveyFlowFeature>
	
	var body: some View {
		NavigationStackStore(
			store.scope(state: \.path, action: \.path)
		) {
			IntroView(store: store)
		} destination: { store in
			SurveyView(store: store)
		}
	}
}
