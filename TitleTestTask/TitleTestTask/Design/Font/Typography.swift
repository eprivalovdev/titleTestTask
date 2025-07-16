//
//  Typography.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import Foundation
import SwiftUI
import UIKit

enum TypographyStyle {
	case h1
	case h2
	case bodyPrimary
	case ctaPrimary
	case footnote
	case footnoteHightlight
	case subtitle
	
	var size: CGFloat {
		switch self {
		case .h1: 32
		case .h2: 26
		case .bodyPrimary: 14
		case .ctaPrimary: 14
		case .footnote: 13
		case .footnoteHightlight: 13
		case .subtitle: 14
		}
	}
	
	var garniture: Garniture {
		switch self {
		case .h1: .kaiseiTokumin
		case .h2: .kaiseiTokumin
		case .bodyPrimary: .poppins
		case .ctaPrimary: .poppins
		case .footnote: .poppins
		case .footnoteHightlight: .poppins
		case .subtitle: .poppins
		}
	}
	
	var fontWeight: FontWeight {
		switch self {
		case .h1: .medium
		case .h2: .medium
		case .bodyPrimary: .light
		case .ctaPrimary: .regular
		case .footnote: .light
		case .footnoteHightlight: .medium
		case .subtitle: .regular
		}
	}
	
	var font: Font {
		Font.custom("\(garniture.rawValue)-\(fontWeight.rawValue)", size: size)
	}
	
	var uiFont: UIFont {
		UIFont.init(name: "\(garniture.rawValue)-\(fontWeight.rawValue)", size: size)!
	}
}

struct BaseTypography: ViewModifier {
	let type: TypographyStyle
	
	func body(content: Content) -> some View {
		content
			.font(type.font)
	}
}

extension View {
	func typography(_ type: TypographyStyle) -> some View {
		return self.modifier(BaseTypography(type: type))
	}
}
