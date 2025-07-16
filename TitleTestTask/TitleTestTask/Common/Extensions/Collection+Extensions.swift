//
//  Collection+Extensions.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation

extension Collection {
	subscript(safe index: Index) -> Element? {
		indices.contains(index) ? self[index] : nil
	}
}
