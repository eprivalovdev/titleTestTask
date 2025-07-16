//
//  MockSurveyService.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation

final class MockSurveyService: SurveyServiceProtocol {
	
	enum MockError: Error {
		case noData
		case decodingFailed
	}
	
	var shouldThrowError: Bool = false
	
	func getSurvey() async throws -> Survey {
		if shouldThrowError {
			throw MockError.noData
		}
		
		guard let url = Bundle.main.url(forResource: "MockSurveyDataJSON", withExtension: "json") else {
			throw MockError.noData
		}
		
		do {
			let data = try Data(contentsOf: url)
			let survey = try JSONDecoder().decode(Survey.self, from: data)
			return survey
		} catch {
			throw MockError.decodingFailed
		}
	}
}
