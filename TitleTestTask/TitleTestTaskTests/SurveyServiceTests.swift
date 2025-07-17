//
//  SurveyServiceTests.swift
//  TitleTestTaskTests
//
//  Created by Єгор Привалов on 17.07.2025.
//

import Foundation
import Testing
@testable import TitleTestTask

struct SurveyServiceTests {
	@Test func testGetSurveySuccess() async throws {
		let mockService = MockSurveyService()
		
		let survey = try await mockService.getSurvey()
		
		#expect(!survey.id.isEmpty)
		#expect(!survey.pages.isEmpty)
	}
	
	@Test func testGetSurveyFailure() async throws {
		let mockService = MockSurveyService()
		
		mockService.shouldThrowError = true
		
		await #expect(throws: MockSurveyService.MockError.noData, performing: { try await mockService.getSurvey() })
	}
}
