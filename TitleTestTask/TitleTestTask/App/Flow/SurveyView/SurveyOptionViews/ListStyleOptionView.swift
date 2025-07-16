//
//  ListStyleOptionView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import SwiftUI

struct ListStyleOptionView: View {
	let option: SurveyOption
	let isSelected: Bool
	
	var body: some View {
		HStack(spacing: 12) {
			textView
			CheckBoxView(isChecked: isSelected)
		}
		.padding(.horizontal, 16)
		.padding(.vertical, 15)
		.background(
			Rectangle()
				.stroke(isSelected ? Color.primary : Color.secondary, lineWidth: 1)
		)
	}
}

extension ListStyleOptionView {
	private var textView: some View {
		VStack(spacing: 1) {
			titleView
			subtitleView()
		}
		.foregroundStyle(Color.primary)
	}
	
	private var titleView: some View {
		Text(option.title)
			.textCase(.uppercase)
			.typography(.footnoteHightlight)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	@ViewBuilder
	private func subtitleView() -> some View {
		if let subtitle = option.subtitle {
			Text(subtitle)
				.typography(.bodyPrimary)
				.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}
