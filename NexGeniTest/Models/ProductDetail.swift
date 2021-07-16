//
//  ProductDetail.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 25/06/2021.
//

import Foundation

public struct ProductDetail: Codable {
    public var data_layer: DataLayer?
    public var good_info: GoodsInfo?
    public var description: Data?
    public var script_data: [ScriptData]?
    
    
    enum CodingKeys: String, CodingKey {
        case data_layer, good_info, description, script_data
    }

    public init(from decoder: Decoder) throws {
        let map = try decoder.container(keyedBy: CodingKeys.self)
        data_layer = try? map.decode(DataLayer.self, forKey: .data_layer)
        good_info = try? map.decode(GoodsInfo.self, forKey: .good_info)
        description = try? map.decode(Data.self, forKey: .description)
        script_data = try? map.decode([ScriptData].self, forKey: .script_data)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(data_layer, forKey: .data_layer)
        try container.encodeIfPresent(good_info, forKey: .good_info)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(script_data, forKey: .script_data)
    }
}
