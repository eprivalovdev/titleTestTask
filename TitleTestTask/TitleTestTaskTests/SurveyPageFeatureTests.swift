//
//  SurveyPageFeatureTests.swift
//  TitleTestTaskTests
//
//  Created by Єгор Привалов on 17.07.2025.
//

import Foundation
import Testing
import ComposableArchitecture
@testable import TitleTestTask

struct SurveyPageFeatureTests {
	/// Tests multi-select: optionTapped toggles selection.
	@Test func testMultiSelectOptionToggles() async throws {
		let option1 = SurveyOption(id: "1", title: "One", subtitle: nil, imageUrl: nil, colorHex: nil)
		let option2 = SurveyOption(id: "2", title: "Two", subtitle: nil, imageUrl: nil, colorHex: nil)
		let page = SurveyPage(
			id: "page1",
			screenTitle: "Title",
			title: "Q?",
			description: nil,
			type: .multiSelect,
			pageStyle: .list,
			continueButtonTitle: "Continue",
			cellStyle: .textOnly,
			options: [option1, option2]
		)
		var state = SurveyPageFeature.State(surveyPage: page)
		let reducer = SurveyPageFeature().body
		
		// Select first
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("1"))
		#expect(state.selected == ["1"])
		
		// Select second
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("2"))
		#expect(state.selected == ["1", "2"])
		
		// Deselect first
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("1"))
		#expect(state.selected == ["2"])
	}
	
	/// Tests single-select: only one option can be selected at a time.
	@Test func testSingleSelectOption() async throws {
		let option1 = SurveyOption(id: "1", title: "One", subtitle: nil, imageUrl: nil, colorHex: nil)
		let option2 = SurveyOption(id: "2", title: "Two", subtitle: nil, imageUrl: nil, colorHex: nil)
		let page = SurveyPage(
			id: "page1",
			screenTitle: "Title",
			title: "Q?",
			description: nil,
			type: .singleSelect,
			pageStyle: .list,
			continueButtonTitle: "Continue",
			cellStyle: .textOnly,
			options: [option1, option2]
		)
		var state = SurveyPageFeature.State(surveyPage: page)
		let reducer = SurveyPageFeature().body
		
		// Select first
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("1"))
		#expect(state.selected == ["1"])
		
		// Select second (should replace first)
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("2"))
		#expect(state.selected == ["2"])
		
		// Deselect second
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("2"))
		#expect(state.selected.isEmpty)
	}
	
	/// Tests that continue button should be disabled if nothing selected
	@Test func testContinueButtonDisabledLogic() async throws {
		let option1 = SurveyOption(id: "1", title: "One", subtitle: nil, imageUrl: nil, colorHex: nil)
		let page = SurveyPage(
			id: "page1",
			screenTitle: "Title",
			title: "Q?",
			description: nil,
			type: .multiSelect,
			pageStyle: .list,
			continueButtonTitle: "Continue",
			cellStyle: .textOnly,
			options: [option1]
		)
		var state = SurveyPageFeature.State(surveyPage: page)
		
		// The button should be disabled if nothing is selected
		#expect(state.selected.isEmpty)
		
		// After selection — enabled
		let reducer = SurveyPageFeature().body
		_ = reducer.reduce(into: &state, action: SurveyPageFeature.Action.optionTapped("1"))
		#expect(!state.selected.isEmpty)
	}
}
