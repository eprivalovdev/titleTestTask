//
//  Survey.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

struct Survey: Codable, Equatable {
	let id: String
	let pages: [SurveyPage]
}
