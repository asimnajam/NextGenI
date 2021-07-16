//
//  DecodableExtension.swift
//  PayBayMaxChallenge
//
//  Created by Syed Asim Najam on 20/06/2021.
//

import Foundation

private let standardJSONDecoder: JSONDecoder = {
    let decorder = JSONDecoder()
    return decorder
}()

extension Decodable {
    static func decodeJSON(fromData data: Data) -> Self? {
        do {
            return try standardJSONDecoder.decode(Self.self, from: data)
        } catch {
            let jsonReadingOptions = JSONSerialization.ReadingOptions(rawValue: 0)
            let json = (try? JSONSerialization.jsonObject(with: data, options: jsonReadingOptions))
            print("Decoding Error: \(error), Raw JSON: \(String(describing: json))")
            return nil
        }
    }
//    ServerResponse) -> ResponseModel
    public static func decode<ResponseModel: Decodable>(serverResponse: ServerResponse) -> ResponseModel? {
        guard let httpResponse = serverResponse.httpUrlResponse else { return nil }
        guard 200 ... 299 ~= httpResponse.statusCode else { return nil }
        guard let data = serverResponse.data else { return nil }
        return decodeJSON(fromData: data) as? ResponseModel
    }
}
