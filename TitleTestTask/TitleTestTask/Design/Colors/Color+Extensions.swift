//
//  Color+Extensions.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import Foundation
import SwiftUI
import UIKit

extension UIColor {
	convenience init(
		light lightModeColor: @escaping @autoclosure () -> UIColor,
		dark darkModeColor: @escaping @autoclosure () -> UIColor
	) {
		self.init { traitCollection in
			switch traitCollection.userInterfaceStyle {
			case .light:
				return lightModeColor()
			case .dark:
				return darkModeColor()
			case .unspecified:
				return lightModeColor()
			@unknown default:
				return lightModeColor()
			}
		}
	}
}

extension Color {
	init(
		light lightModeColor: @escaping @autoclosure () -> Color,
		dark darkModeColor: @escaping @autoclosure () -> Color
	) {
		self.init(
			UIColor(
				light: UIColor(lightModeColor()),
				dark: UIColor(darkModeColor())
			)
		)
	}
}

extension UIColor {
	convenience init(_ rgbValue: UInt,_ alpha: CGFloat = 1.0) {
		self.init(
			red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
			green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
			blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
			alpha: CGFloat(alpha)
		)
	}
}

extension Color {
	init(_ hex: UInt, alpha: Double = 1) {
		self.init(
			.sRGB,
			red: Double((hex >> 16) & 0xff) / 255,
			green: Double((hex >> 08) & 0xff) / 255,
			blue: Double((hex >> 00) & 0xff) / 255,
			opacity: alpha
		)
	}
}

extension Color {
	init(hexString: String, alpha: Double = 1) {
		if let number = UInt(hexString, radix: 16) {
			self.init(number, alpha: alpha)
		} else {
			self.init(0x000000, alpha: 0)
		}
	}
}

extension Color {
	init(hex: String) {
		let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
		var int: UInt64 = 0
		Scanner(string: hex).scanHexInt64(&int)
		let a, r, g, b: UInt64
		switch hex.count {
		case 3:
			(a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
		case 6:
			(a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
		case 8:
			(a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
		default:
			(a, r, g, b) = (1, 1, 1, 0)
		}
		
		self.init(
			.sRGB,
			red: Double(r) / 255,
			green: Double(g) / 255,
			blue:  Double(b) / 255,
			opacity: Double(a) / 255
		)
	}
}

extension Color {
	var uiColor: UIColor {
		return UIColor(self)
	}
}

