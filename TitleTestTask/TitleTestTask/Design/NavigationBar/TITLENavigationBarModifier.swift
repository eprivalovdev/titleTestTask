//
//  TITLENavigationBarModifier.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 15.07.2025.
//

import Foundation
import SwiftUI

struct TITLENavigationBarModifier: ViewModifier {
	init() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = UIColor.white
		
		appearance.titleTextAttributes = [
			.font: TypographyStyle.subtitle.uiFont,
			.foregroundColor: Color.primary.uiColor
		]
		
		appearance.largeTitleTextAttributes = [
			.font: UIFont.systemFont(ofSize: 30, weight: .semibold),
			.foregroundColor: Color.primary.uiColor
		]
		
		appearance.shadowColor = .clear
		
		let backImage = UIImage(named: "arrowBackIcon") ?? UIImage(systemName: "chevron.left")!
		appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
		
		let backButtonAppearance = UIBarButtonItemAppearance()
		backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
		appearance.backButtonAppearance = backButtonAppearance
		
		let navBar = UINavigationBar.appearance()
		navBar.standardAppearance = appearance
		navBar.scrollEdgeAppearance = appearance
		navBar.compactAppearance = appearance
		navBar.tintColor = Color.primary.uiColor
	}
	
	func body(content: Content) -> some View {
		content
	}
}

extension View {
	func titleNavigationBar() -> some View {
		return self.modifier(TITLENavigationBarModifier())
	}
}
