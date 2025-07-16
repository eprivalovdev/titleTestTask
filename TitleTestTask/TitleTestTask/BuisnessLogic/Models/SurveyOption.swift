//
//  SurveyOption.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

struct SurveyOption: Codable, Hashable, Identifiable, Equatable {
	let id: String
	let title: String
	let subtitle: String?
	let imageUrl: String?
	let colorHex: String?
}
