//
//  MockAnswersStorage.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 17.07.2025.
//

import Foundation

final class MockAnswersStorage: SurveyAnswersStorage {
	var savedAnswers: [String: Set<String>] = [:]
	var loadAnswers: [String: Set<String>] = [:]
	
	func save(_ answers: [String : Set<String>]) {
		savedAnswers = answers
	}
	
	func load() -> [String : Set<String>] {
		loadAnswers
	}
}
