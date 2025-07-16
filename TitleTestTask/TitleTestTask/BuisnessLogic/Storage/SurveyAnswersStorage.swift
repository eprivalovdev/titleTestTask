//
//  SurveyAnswersStorage.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation

protocol SurveyAnswersStorage {
	func save(_ answers: [String: Set<String>])
	func load() -> [String: Set<String>]
}

struct UserDefaultsSurveyAnswersStorage: SurveyAnswersStorage {
	private let key = "survey_answers"
	
	func save(_ answers: [String: Set<String>]) {
		if let data = try? JSONEncoder().encode(answers) {
			UserDefaults.standard.set(data, forKey: key)
		}
	}
	
	func load() -> [String: Set<String>] {
		guard
			let data = UserDefaults.standard.data(forKey: key),
			let decoded = try? JSONDecoder().decode([String: Set<String>].self, from: data)
		else {
			return [:]
		}
		return decoded
	}
}
