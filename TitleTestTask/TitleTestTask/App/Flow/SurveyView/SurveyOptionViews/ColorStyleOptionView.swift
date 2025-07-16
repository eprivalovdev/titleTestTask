//
//  ColorStyleOptionView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import SwiftUI

struct ColorStyleOptionView: View {
	let option: SurveyOption
	let isSelected: Bool
	
	var body: some View {
		contentView
			.overlay(alignment: .topTrailing) {
				CheckBoxView(isChecked: isSelected)
					.padding([.top, .trailing], 8)
			}
			.background(
				Rectangle()
					.stroke(isSelected ? Color.primary : Color.secondary, lineWidth: 1)
			)
	}
}

extension ColorStyleOptionView {
	private var contentView: some View {
		VStack(spacing: 8) {
			colorView()
			titleView
		}
		.padding(.vertical, 14)
		.padding(.horizontal, 16)
		.frame(maxWidth: .infinity)
	}
	
	@ViewBuilder
	private func colorView() -> some View {
		if let color = option.colorHex.flatMap(Color.init(hex:)) {
			Rectangle()
				.fill(color)
				.frame(width: 32, height: 32)
				.padding(.top, 12.5)
		}
	}
	
	private var titleView: some View {
		Text(option.title)
			.textCase(.uppercase)
			.typography(isSelected ? .footnoteHightlight : .footnote)
			.padding(.bottom, 8)
	}
}
