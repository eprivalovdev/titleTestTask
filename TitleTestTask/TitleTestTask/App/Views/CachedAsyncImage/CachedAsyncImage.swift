//
//  CachedAsyncImage.swift
//  TitleTestTask
//
//  Created by Єгор Привалов on 16.07.2025.
//

import Foundation
import SwiftUI

struct CachedAsyncImage<Content: View, Placeholder: View>: View {
	let url: URL
	let content: (Image) -> Content
	let placeholder: () -> Placeholder
	
	@State private var loadedImage: Image?
	
	var body: some View {
		Group {
			if let image = loadedImage {
				content(image)
			} else {
				placeholder()
					.onAppear {
						loadImage()
					}
			}
		}
	}
}

extension CachedAsyncImage {
	private func loadImage() {
		let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
		
		if let cachedResponse = URLCache.shared.cachedResponse(for: request),
			 let uiImage = UIImage(data: cachedResponse.data) {
			loadedImage = Image(uiImage: uiImage)
			return
		}
		
		URLSession.shared.dataTask(with: request) { data, response, _ in
			guard
				let data = data,
				let response = response,
				let uiImage = UIImage(data: data)
			else {
				return
			}
			
			let cachedResponse = CachedURLResponse(response: response, data: data)
			URLCache.shared.storeCachedResponse(cachedResponse, for: request)
			
			DispatchQueue.main.async {
				self.loadedImage = Image(uiImage: uiImage)
			}
		}.resume()
	}
}
