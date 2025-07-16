//
//  SurveyPage.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

struct SurveyPage: Codable, Hashable, Equatable {
	let id: String
	let screenTitle: String
	let title: String
	let description: String?
	let type: PageType
	let pageStyle: PageStyle
	let continueButtonTitle: String?
	let cellStyle: CellStyle
	let options: [SurveyOption]
}
