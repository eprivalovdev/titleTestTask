//
//  FlexibleGridView.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import SwiftUI

struct FlexibleGridView<Item: Identifiable, Content: View>: View {
	let items: [Item]
	let columnsCount: Int
	let spacing: CGFloat
	let onTap: (Item) -> Void
	let content: (Item) -> Content
	
	init(
		items: [Item],
		columnsCount: Int = 2,
		spacing: CGFloat = 12,
		onTap: @escaping (Item) -> Void,
		@ViewBuilder content: @escaping (Item) -> Content
	) {
		self.items = items
		self.columnsCount = columnsCount
		self.spacing = spacing
		self.onTap = onTap
		self.content = content
	}
	
	var body: some View {
		let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: columnsCount)
		
		LazyVGrid(columns: columns, spacing: spacing) {
			ForEach(items) { item in
				content(item)
					.contentShape(Rectangle())
					.onTapGesture {
						onTap(item)
					}
			}
		}
		.padding(.vertical, 4)
	}
}
