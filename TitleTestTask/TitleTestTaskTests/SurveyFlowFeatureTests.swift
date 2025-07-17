//
//  SurveyFlowFeatureTests.swift
//  TitleTestTaskTests
//
//  Created by Єгор Привалов on 17.07.2025.
//

import Foundation
import Testing
import ComposableArchitecture
@testable import TitleTestTask

struct SurveyFlowFeatureTests {
	/// Tests that after loading the survey and starting, the first page appears in the navigation stack.
	@Test func testLoadsSurveyAndStartsOnFirstPage() async throws {
		let mockService = MockSurveyService()
		let mockStorage = MockAnswersStorage()
		let survey = try await mockService.getSurvey()
		var state = SurveyFlowFeature.State()
		let reducer = SurveyFlowFeature().body
		
		// Load survey
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [SurveyFlowFeature.Action.surveyLoaded(survey)],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		#expect(!state.isLoading)
		#expect(state.survey == survey)
		
		// Start survey
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [SurveyFlowFeature.Action.startSurvey],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		let firstStackId = state.path.ids.first
		
		#expect(state.path.count == 1)
		#expect(firstStackId != nil)
		#expect(state.path[id: firstStackId!]?.isFirstPage == true)
	}
	
	/// Tests that selecting an option saves the answer and moves to the next page.
	@Test func testSelectingOptionMovesToNextPageAndSavesAnswers() async throws {
		let mockService = MockSurveyService()
		let mockStorage = MockAnswersStorage()
		let survey = try await mockService.getSurvey()
		
		// Load and start survey
		var state = SurveyFlowFeature.State()
		let reducer = SurveyFlowFeature().body
		
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [
				SurveyFlowFeature.Action.surveyLoaded(survey),
				SurveyFlowFeature.Action.startSurvey
			],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		let firstPage = survey.pages[0]
		let optionId = firstPage.options[0].id
		let firstStackId = state.path.ids.first!
		
		// Tap option
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [SurveyFlowFeature.Action.path(.element(id: firstStackId, action: .optionTapped(optionId)))],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		#expect(state.answers[firstPage.id]?.contains(optionId) == true)
		#expect(state.path[id: firstStackId]?.selected.contains(optionId) == true)
		#expect(mockStorage.savedAnswers[firstPage.id]?.contains(optionId) == true)
		
		// Continue to next page
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [SurveyFlowFeature.Action.path(.element(id: firstStackId, action: .continueTapped))],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		let secondPage = survey.pages[1]
		let secondStackId = state.path.ids.last!
		
		#expect(state.path.count == 2)
		#expect(state.path[id: secondStackId]?.surveyPage.id == secondPage.id)
	}
	
	/// Tests that the reducer correctly handles a survey loading error.
	@Test func testHandlesSurveyLoadingError() async throws {
		let mockService = MockSurveyService()
		mockService.shouldThrowError = true
		let mockStorage = MockAnswersStorage()
		var state = SurveyFlowFeature.State()
		let reducer = SurveyFlowFeature().body
		
		// Simulate intro appeared (triggers loading)
		reduceWithDependencies(
			reducer,
			state: &state,
			actions: [SurveyFlowFeature.Action.introAppeared],
			mockService: mockService,
			mockStorage: mockStorage
		)
		
		#expect(state.isLoading)
	}
}

extension SurveyFlowFeatureTests {
	func reduceWithDependencies<R: Reducer>(
		_ reducer: R,
		state: inout R.State,
		actions: [R.Action],
		mockService: SurveyServiceProtocol,
		mockStorage: SurveyAnswersStorage
	) {
		withDependencies {
			$0.surveyService = mockService
			$0.surveyAnswersStorage = mockStorage
		} operation: {
			for action in actions {
				_ = reducer.reduce(into: &state, action: action)
			}
		}
	}
}
