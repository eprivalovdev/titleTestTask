//
//  IntroView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import SwiftUI
import ComposableArchitecture

struct IntroView: View {
	let store: StoreOf<SurveyFlowFeature>
	
	var body: some View {
		WithViewStore(store, observe: { $0 }) { viewStore in
			ZStack {
				backgroundImageView
				gradientView
				contentView(viewStore)
				loadingView(viewStore)
			}
			.onAppear {
				viewStore.send(.introAppeared)
			}
		}
	}
}

extension IntroView {
	private var backgroundImageView: some View {
		Image(.introBackground)
			.resizable()
			.ignoresSafeArea()
	}
	
	private var gradientView: some View {
		LinearGradient(
			colors: [Color.black, Color.black.opacity(0)],
			startPoint: .bottom,
			endPoint: .top
		)
		.ignoresSafeArea()
	}
	
	private var titleView: some View {
		Text("INTROVIEW_TITLE")
			.typography(.h1)
			.foregroundStyle(Color.textDarkMode)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private func takeQuizButton(_ viewStore: ViewStoreOf<SurveyFlowFeature>) -> some View {
		Button {
			viewStore.send(.startSurvey)
		} label: {
			Text("INTROVIEW_BUTTON_TITLE")
		}
		.buttonStyle(MainButtonStyle(buttonConfig: .dark))
	}
	
	private func contentView(_ viewStore: ViewStoreOf<SurveyFlowFeature>) -> some View {
		VStack(spacing: 61) {
			Spacer()
			titleView
			takeQuizButton(viewStore)
		}
		.padding(.horizontal, 20)
		.padding(.bottom, 28)
	}
	
	@ViewBuilder
	private func loadingView(_ viewStore: ViewStoreOf<SurveyFlowFeature>) -> some View {
		if viewStore.isLoading {
			ProgressView()
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.background(Color.black.opacity(0.3))
		}
	}
}
