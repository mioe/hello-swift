// by mioe

import Foundation

enum NetworkError: Error {
	case invalidURL
	case invalidResponse
	case http(status: Int)
	case decoding(Error)
}

enum Order: String {
	case asc, desc
}

final class NetworkManager {
	private let baseURL: URL
	private let session: URLSession
	private let decoder: JSONDecoder

	init(
		// baseURL: URL = URL(string: "http://localhost:4321")!,
		baseURL: URL = URL(string: "https://mioe.app")!,
		session: URLSession = .shared
	) {
		self.baseURL = baseURL
		self.session = session

		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		self.decoder = decoder
	}

	func getMockF12m4l1(
		page: Int = 1,
		limit: Int = 3,
		createdAt: Order = .asc
	) async throws -> [Tweet] {
		let query: [String: String] = [
			"page": String(page),
			"limit": String(limit),
			"createdAt": createdAt.rawValue,
		]

		let url = try makeURL(path: "/hono/mock/f12m4l1", query: query)
		let (data, response) = try await session.data(from: url)

		guard let http = response as? HTTPURLResponse else {
			throw NetworkError.invalidResponse
		}
		guard (200..<300).contains(http.statusCode) else {
			throw NetworkError.http(status: http.statusCode)
		}

		do {
			let dtos = try decoder.decode([TweetDTO].self, from: data)
			// print(dtos)
			return TweetMapper.map(dtos)
		} catch {
			throw NetworkError.decoding(error)
		}
	}

	private func makeURL(path: String, query: [String: String]) throws -> URL {
		guard
			var components = URLComponents(
				url: baseURL.appendingPathComponent(path),
				resolvingAgainstBaseURL: false
			)
		else {
			throw NetworkError.invalidURL
		}
		components.queryItems = query.map {
			URLQueryItem(name: $0.key, value: $0.value)
		}

		guard let url = components.url else {
			throw NetworkError.invalidURL
		}
		return url
	}
}
