//
//  SurveyServiceKey.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import ComposableArchitecture

struct SurveyServiceKey: DependencyKey {
	static let liveValue: (Bool) -> SurveyServiceProtocol = { useMock in
		useMock ? MockSurveyService() : SurveyService()
	}
}

extension DependencyValues {
	var surveyService: (Bool) -> SurveyServiceProtocol {
		get { self[SurveyServiceKey.self] }
		set { self[SurveyServiceKey.self] = newValue }
	}
}
