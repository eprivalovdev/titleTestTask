//
//  RemoteConfigSurveyService.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import FirebaseRemoteConfig

final class SurveyService: SurveyServiceProtocol {
	func getSurvey() async throws -> Survey {
		let remoteConfig = RemoteConfig.remoteConfig()
		
		try await remoteConfig.fetchAndActivate()
		
		let value = remoteConfig.configValue(forKey: "survey")
		
		do {
			let survey = try JSONDecoder().decode(Survey.self, from: value.dataValue)
			return survey
		} catch {
			print("Failed to decode survey from RemoteConfig: \(error)")
			throw error
		}
	}
}
