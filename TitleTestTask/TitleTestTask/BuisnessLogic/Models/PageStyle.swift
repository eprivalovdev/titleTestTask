//
//  PageStyle.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

enum PageStyle: Codable, Equatable, Hashable {
	case list
	case grid(columns: Int)
	
	private enum RawCodingKeys: String, Codable {
		case list
		case grid2 = "grid-2"
		case grid3 = "grid-3"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		
		switch rawValue {
		case "list":
			self = .list
		case "grid-2":
			self = .grid(columns: 2)
		case "grid-3":
			self = .grid(columns: 3)
		default:
			throw DecodingError.dataCorruptedError(in: container, debugDescription: "Unknown page type: \(rawValue)")
		}
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		switch self {
		case .list:
			try container.encode("list")
		case .grid(let columns):
			try container.encode("grid-\(columns)")
		}
	}
}
