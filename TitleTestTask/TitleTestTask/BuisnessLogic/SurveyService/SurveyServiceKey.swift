//
//  SurveyServiceKey.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import ComposableArchitecture

struct SurveyServiceKey: DependencyKey {
	static let liveValue: SurveyServiceProtocol = {
#if DEBUG
		return MockSurveyService()
#else
		return SurveyService()
#endif
	}()
}

extension DependencyValues {
	var surveyService: SurveyServiceProtocol {
		get { self[SurveyServiceKey.self] }
		set { self[SurveyServiceKey.self] = newValue }
	}
}
