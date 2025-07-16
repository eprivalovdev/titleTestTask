//
//  SurveyFlowFeature.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import ComposableArchitecture

struct SurveyFlowFeature: Reducer {
	struct State: Equatable {
		var isLoading: Bool = false
		var survey: Survey?
		var path = StackState<SurveyPageFeature.State>()
		var answers: [String: Set<String>] = [:]
	}
	
	enum Action: Equatable {
		case introAppeared
		case surveyLoaded(Survey)
		case dataLoadError
		case startSurvey
		case path(StackAction<SurveyPageFeature.State, SurveyPageFeature.Action>)
		case page(id: SurveyPageFeature.State.ID, action: SurveyPageFeature.Action)
	}
	
	@Dependency(\DependencyValues.surveyService) var surveyService
	@Dependency(\DependencyValues.surveyAnswersStorage) var answersStorage
	
	var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .introAppeared:
				state.isLoading = true
				return loadSurveyEffect()
			case let .surveyLoaded(survey):
				state.isLoading = false
				state.survey = survey
				state.answers = answersStorage.load()
				return .none
			case .dataLoadError:
				state.isLoading = false
				return .none
			case .startSurvey:
				guard let firstPage = state.survey?.pages.first else { return .none }
				state.path.append(makePageState(for: firstPage, with: state.answers, isFirstPage: true))
				return .none
			case let .path(.element(id, .optionTapped(optionId))):
				guard let pageId = state.path[id: id]?.surveyPage.id else { return .none }
				toggleOption(
					&state.answers,
					for: pageId,
					optionId: optionId
				)
				state.path[id: id]?.selected = state.answers[pageId] ?? []
				answersStorage.save(state.answers)
				return .none
			case let .path(.element(id, .continueTapped)):
				guard
					let survey = state.survey,
					let currentPageId = state.path[id: id]?.surveyPage.id,
					let nextPage = nextSurveyPage(after: currentPageId, in: survey)
				else {
					return .none
				}
				
				state.path.append(makePageState(for: nextPage, with: state.answers))
				return .none
			default:
				return .none
			}
		}
		.forEach(\.path, action: /Action.path) {
			SurveyPageFeature()
		}
	}
}

private extension SurveyFlowFeature {
	func loadSurveyEffect() -> Effect<Action> {
		.run { send in
			do {
				let survey = try await surveyService.getSurvey()
				await send(.surveyLoaded(survey))
			} catch {
				await send(.dataLoadError)
			}
		}
	}
	
	private func makePageState(for page: SurveyPage, with answers: [String: Set<String>], isFirstPage: Bool = false) -> SurveyPageFeature.State {
		SurveyPageFeature.State(
			surveyPage: page,
			selected: answers[page.id] ?? [],
			isFirstPage: isFirstPage
		)
	}
	
	func toggleOption(_ answers: inout [String: Set<String>], for pageId: String, optionId: String) {
		var set = answers[pageId] ?? []
		if set.contains(optionId) {
			set.remove(optionId)
		} else {
			set.insert(optionId)
		}
		answers[pageId] = set
	}
	
	func nextSurveyPage(after currentPageId: String, in survey: Survey) -> SurveyPage? {
		guard let currentIndex = survey.pages.firstIndex(where: { $0.id == currentPageId }) else { return nil }
		let nextIndex = currentIndex + 1
		return survey.pages[safe: nextIndex]
	}
}
