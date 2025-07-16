//
//  MainButtonStyle.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import Foundation
import SwiftUI

struct MainButtonStyle: ButtonStyle {
	
	enum ButtonConfig {
		case light, dark
	}
	
	var buttonConfig: ButtonConfig
	
	init(buttonConfig: ButtonConfig = .dark) {
		self.buttonConfig = buttonConfig
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.textCase(.uppercase)
			.typography(.ctaPrimary)
			.foregroundStyle(buttonConfig == .light ? Color.ButtonSurface.lightTitle : Color.ButtonSurface.darkTitle)
			.frame(maxWidth: .infinity)
			.frame(height: 48)
			.background {
				Rectangle()
					.foregroundStyle(buttonConfig == .light ? Color.ButtonSurface.lightBackground : Color.ButtonSurface.darkBackground)
			}
	}
}
