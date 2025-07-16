//
//  SurveyPageFeature.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import ComposableArchitecture

@Reducer
struct SurveyPageFeature {
	struct State: Equatable, Identifiable {
		let id: String
		let surveyPage: SurveyPage
		var selected: Set<String>
		var isFirstPage: Bool = false
		
		init(surveyPage: SurveyPage, selected: Set<String> = [], isFirstPage: Bool = false) {
			self.id = surveyPage.id
			self.surveyPage = surveyPage
			self.selected = selected
			self.isFirstPage = isFirstPage
		}
	}
	
	enum Action: Equatable {
		case optionTapped(String)
		case continueTapped
	}
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .optionTapped(let optionId):
				if state.selected.contains(optionId) {
					state.selected.remove(optionId)
				} else {
					state.selected.insert(optionId)
				}
				return .none
			case .continueTapped:
				return .none
			}
		}
	}
}
