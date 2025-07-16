//
//  SurveyAnswersStorageKey.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import ComposableArchitecture

struct SurveyAnswersStorageKey: DependencyKey {
	static let liveValue: SurveyAnswersStorage = UserDefaultsSurveyAnswersStorage()
}

extension DependencyValues {
	var surveyAnswersStorage: SurveyAnswersStorage {
		get { self[SurveyAnswersStorageKey.self] }
		set { self[SurveyAnswersStorageKey.self] = newValue }
	}
}
