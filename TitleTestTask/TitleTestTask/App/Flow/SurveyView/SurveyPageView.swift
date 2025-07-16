//
//  SurveyView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import ComposableArchitecture
import SwiftUI

struct SurveyView: View {
	let store: StoreOf<SurveyPageFeature>
	
	var body: some View {
		WithViewStore(store, observe: { $0 }) { viewStore in
			ZStack(alignment: .bottom) {
				VStack(spacing: .zero) {
					titleView(viewStore)
					scrollView(viewStore)
				}
				
				bottomView(viewStore)
			}
			.ignoresSafeArea(edges: .bottom)
			.padding(.horizontal, 20)
			.navigationTitle(viewStore.surveyPage.screenTitle)
			.navigationBarTitleDisplayMode(.inline)
			.navigationBarBackButtonHidden(viewStore.isFirstPage)
		}
	}
}

extension SurveyView {
	private func titleView(_ viewStore: ViewStoreOf<SurveyPageFeature>) -> some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(viewStore.surveyPage.title)
				.typography(.h2)
			if let subtitle = viewStore.surveyPage.description {
				Text(subtitle)
					.typography(.bodyPrimary)
			}
		}
		.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private func scrollView(_ viewStore: ViewStoreOf<SurveyPageFeature>) -> some View {
		ScrollView(.vertical) {
			contentView(viewStore)
				.padding(.bottom, 140)
		}
		.padding(.top, 24)
		.scrollIndicators(.hidden)
	}
	
	private func bottomView(_ viewStore: ViewStoreOf<SurveyPageFeature>) -> some View {
		ZStack(alignment: .bottom) {
			VStack(spacing: .zero) {
				LinearGradient(colors: [Color.white, Color.clear], startPoint: .bottom, endPoint: .top)
				Color.white
			}
			
			Button {
				viewStore.send(.continueTapped)
			} label: {
				Text(viewStore.surveyPage.continueButtonTitle ?? "")
			}
			.buttonStyle(MainButtonStyle(buttonConfig: .light))
			.padding(.bottom, 56)
		}
		.frame(height: 144)
		.ignoresSafeArea(edges: .bottom)
	}
	
	private func contentView(_ viewStore: ViewStoreOf<SurveyPageFeature>) -> some View {
		let page = viewStore.surveyPage
		let columns: Int = {
			switch page.pageStyle {
			case .list:
				return 1
			case .grid(let count):
				return count
			}
		}()
		
		return FlexibleGridView(
			items: page.options,
			columnsCount: columns,
			spacing: 12,
			onTap: { option in
				let selected = viewStore.selected
				switch page.type {
				case .multiSelect:
					viewStore.send(.optionTapped(option.id))
				case .singleSelect:
					if selected.contains(option.id) {
						viewStore.send(.optionTapped(option.id))
					} else {
						for id in selected where id != option.id {
							viewStore.send(.optionTapped(id))
						}
						viewStore.send(.optionTapped(option.id))
					}
				}
			},
			content: { option in
				optionCell(
					option: option,
					isSelected: viewStore.selected.contains(option.id),
					style: page.cellStyle
				)
			}
		)
	}
}

extension SurveyView {
	@ViewBuilder
	private func optionCell(option: SurveyOption, isSelected: Bool, style: CellStyle) -> some View {
		switch style {
		case .textOnly:
			ListStyleOptionView(option: option, isSelected: isSelected)
		case .image:
			ImageStyleOptionView(option: option, isSelected: isSelected)
		case .color:
			ColorStyleOptionView(option: option, isSelected: isSelected)
		}
	}
}
