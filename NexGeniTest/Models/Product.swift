//
//  Product.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import Foundation

public struct ProductData: Codable {
    public var goodsStatus: Int = 0
    public var agvRate: Double = 0.0
    public var agvStar: Double = 0.0
    public var goodsUrl: String = ""
    public var goodsWebSku: String = ""
    public var reviewLink: String = ""
    public var goodsImage: String = ""
    public var displayPrice: Double = 0.0
    public var appDisplayPrice: Double = 0.0
    public var appPriceType: String = ""
    public var priceType: String = ""
    public var discount: Int = 0
    public var goodsItemType: String = ""
    public var goodsSn: String = ""
    public var wareCode: String = ""
    public var shopPrice: Double = 0.0
    public var reviewCount: Int = 0
    public var favoriteCount: Int = 0
    public var youtube: String = ""
    public var goodsTitle: String = ""
    public var subTitle: String = ""
    public var shopCode: String = ""
    public var catId: Int = 0
    public var labelIds: String = ""
    public var installmentId: String = ""
    public var firstUpTime: String = ""
    public var urlTitle: String = ""
    public var originalUrl: String = ""
    public var thumbExtendUrl: String = ""
    
    
    public var stockFlag: Int = 0
    public var payStartTime: Int = 0
    public var payEndTime: Int = 0
    public var mailPriceActive: Int = 0
    public var mailPriceDiscount: Int = 0
    public var appPayStartTime: String = ""
    public var appPayEndTime: String = ""
    public var activities: [String] = []
    public var coupons: [String] = []
    public var brandName: String = ""
    public var brandCode: String = ""
    public var mailPrice: Double = 0
    public var mailPriceCipherText: String = ""
    public var hasLabel: Int = 0
    public var activeTags: [String] = []
    public var serverTags: [String] = []
}
