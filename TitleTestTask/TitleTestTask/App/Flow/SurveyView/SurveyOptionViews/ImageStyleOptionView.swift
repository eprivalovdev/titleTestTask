//
//  ImageStyleOptionView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import SwiftUI

struct ImageStyleOptionView: View {
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

extension ImageStyleOptionView {
	private var contentView: some View {
		VStack(spacing: 4) {
			imageView()
			titleView
		}
		.padding(8)
		.frame(maxWidth: .infinity)
	}
	
	@ViewBuilder
	private func imageView() -> some View {
		if let url = option.imageUrl.flatMap(URL.init) {
			CachedAsyncImage(
				url: url,
				content: { (image: Image) in
					image
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 108, height: 122)
						.clipped()
				},
				placeholder: {
					Color.secondary.opacity(0.1)
						.frame(width: 108, height: 122)
				}
			)
		}
	}
	
	private var titleView: some View {
		Text(option.title)
			.textCase(.uppercase)
			.typography(isSelected ? .footnoteHightlight : .footnote)
	}
}
