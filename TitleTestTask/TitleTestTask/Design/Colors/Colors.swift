//
//  Colors.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import Foundation
import SwiftUI

extension Color {
	
	static let primary = Color(ColorCodes.primary)
	static let secondary = Color(ColorCodes.secondary)
	static let textDarkMode = Color(ColorCodes.textDarkMode)
	
	enum ButtonSurface {
		static let lightTitle = Color(light: Color(ColorCodes.textDarkMode), dark: Color(ColorCodes.textDarkMode))
		static let lightBackground = Color(light: Color(ColorCodes.primary), dark: Color(ColorCodes.primary))
		
		static let darkTitle = Color(light: Color(ColorCodes.primary), dark: Color(ColorCodes.primary))
		static let darkBackground = Color(light: Color(ColorCodes.textDarkMode), dark: Color(ColorCodes.textDarkMode))
	}
	
	enum CheckBoxView {
		static let stroke = Color(light: Color(ColorCodes.secondary), dark: Color(ColorCodes.secondary))
		static let background = Color(light: Color(ColorCodes.primary), dark: Color(ColorCodes.primary))
		static let iconColor = Color(light: Color(ColorCodes.textDarkMode), dark: Color(ColorCodes.textDarkMode))
	}
}
