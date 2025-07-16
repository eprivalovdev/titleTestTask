//
//  CheckBoxView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import SwiftUI

struct CheckBoxView: View {
	var isChecked: Bool
	
	var body: some View {
		ZStack {
			Rectangle()
				.strokeBorder(isChecked ? Color.clear : Color.CheckBoxView.stroke, lineWidth: 1)
				.background(
					Rectangle()
						.fill(isChecked ? Color.CheckBoxView.background : Color.clear)
				)
				.frame(width: 20, height: 20)
			
			if isChecked {
				Image(.doneIcon)
					.foregroundColor(Color.CheckBoxView.iconColor)
					.frame(width: 14, height: 14)
			}
		}
	}
}
