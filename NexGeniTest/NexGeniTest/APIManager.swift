//
//  APIManager.swift
//  NexGeniTest
//
//  Created by Syed Asim Najam on 24/06/2021.
//

import Foundation
import Models
import Networking

let kAPIManager = APIManager.shared
extension NSAttributedString {
    var trimmedAttributedString: NSAttributedString? {
        let invertedSet = CharacterSet.whitespacesAndNewlines.inverted
        let startRange = string.rangeOfCharacter(from: invertedSet)
        let endRange = string.rangeOfCharacter(from: invertedSet, options: .backwards)
        guard let startLocation = startRange?.upperBound, let endLocation = endRange?.lowerBound else {
            return NSAttributedString(string: string)
        }
        let location = string.distance(from: string.startIndex, to: startLocation) - 1
        let length = string.distance(from: startLocation, to: endLocation) + 2
        let range = NSRange(location: location, length: length)
        return attributedSubstring(from: range)
    }
}

final class APIManager {
    public static let shared: APIManager = APIManager()
    private let urlSession: URLSession = URLSession.shared
    
    private init() {}
}

//extension APIManager {
//    static var productDetailData: Data {
//       let jsonString = """
//{
//    "data_layer": {
//        "goods": {
//            "title": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
//        }
//    },
//    "good_info": {
//        "baseGoodsInfo" : {
//            "brandName": "AMAZFIT"
//        }
//    },
//    "description": "Hello",
//    "script_data": [
//        {
//            "aggregateRating": {
//                "ratingValue": "4.78"
//            }
//        }
//    ]
//}
//"""
//        return jsonString.data(using: .utf8)!
//    }
//}

//protocol LiveAPICommunicator {
//    func callLiveAPI(success: @escaping ((Live) -> Void), failure: @escaping ((Error?) -> Void))
//}

protocol ProductsAPICommunicator {
    func getProducts(success: @escaping ((Products) -> Void), failure: @escaping ((Error?) -> Void))
}

struct Catagoryy: Codable {
    let name: String
    let level: Int
    let link: String
}
//.getProducts(by: "smart-watches-c_11330")
extension APIManager: ProductsAPICommunicator {
    func getProducts(success: @escaping ((Products) -> Void), failure: @escaping ((Error?) -> Void)) {
        urlSession.performRequest(
            resource: .getProducts(by: "smart-watches-c_11330"),
            success: { products in
                DispatchQueue.main.async {
                    success(products)
                }
            }, failure: { error in
                failure(error)
            }
        )
    }
    
    func getProductDetail(by productUrl: String, success: @escaping ((ProductDetail) -> Void), failure: @escaping ((Error?) -> Void)) {
        var jsonData: Data {
            """
{
"action": "1-questions-newest-tag-ios",
"data": "{"id":"57471635","body":"<div class=\"question-summary\" id=\"question-summary-57471635\">\r\n <div class=\"statscontainer\">\r\n <div class=\"stats\">\r\n <div class=\"vote\">\r\n <div class=\"votes\">\r\n <span class=\"vote-count-post \"><strong>0</strong></span>\r\n <div class=\"viewcount\">votes</div>\r\n </div>\r\n </div>\r\n <div class=\"status unanswered\">\r\n <strong>0</strong>answers\r\n </div>\r\n </div>\r\n <div class=\"views \" title=\"1 view\">\r\n 1 view\r\n</div>\r\n </div>\r\n <div class=\"summary\">\r\n <h3><a href=\"/questions/57471635/firebase-crashlytics-not-uploading-dysm-automatically\" class=\"question-hyperlink\">Firebase crashlytics not uploading dysm automatically</a></h3>\r\n <div class=\"excerpt\">\r\n I'm having problem when migrating to firebase crashlytics from fabric with the automatic upload of dysm. Ever since i migrated to firebase the automatic upload isn't working.\n\nI have already tried ...\r\n </div>\r\n <div class=\"tags t-ios t-xcode t-firebase t-crashlytics\">\r\n <a href=\"/questions/tagged/ios\" class=\"post-tag\" title=\"show questions tagged &#39;ios&#39;\" rel=\"tag\">ios</a> <a href=\"/questions/tagged/xcode\" class=\"post-tag\" title=\"show questions tagged &#39;xcode&#39;\" rel=\"tag\">xcode</a> <a href=\"/questions/tagged/firebase\" class=\"post-tag\" title=\"show questions tagged &#39;firebase&#39;\" rel=\"tag\">firebase</a> <a href=\"/questions/tagged/crashlytics\" class=\"post-tag\" title=\"show questions tagged &#39;crashlytics&#39;\" rel=\"tag\">crashlytics</a> \r\n </div>\r\n <div class=\"started fr\">\r\n <div class=\"user-info \">\r\n <div class=\"user-action-time\">\r\n <a href=\"/questions/57471635/firebase-crashlytics-not-uploading-dysm-automatically\" class=\"started-link\">asked <span title=\"2019-08-13 05:33:14Z\" class=\"relativetime\">just now</span></a>\r\n </div>\r\n <div class=\"user-gravatar32\">\r\n <a href=\"/users/6570443/dmram\"><div class=\"gravatar-wrapper-32\"><img src=\"https://www.gravatar.com/avatar/b2db2030e92f08419e8b6a4d303a9ada?s=32&amp;d=identicon&amp;r=PG&amp;f=1\" alt=\"\" width=\"32\" height=\"32\"></div></a>\r\n </div>\r\n <div class=\"user-details\">\r\n <a href=\"/users/6570443/dmram\">dmram</a>\r\n <div class=\"-flair\">\r\n <span class=\"reputation-score\" title=\"reputation score \" dir=\"ltr\">40</span><span title=\"8 bronze badges\" aria-hidden=\"true\"><span class=\"badge3\"></span><span class=\"badgecount\">8</span></span><span class=\"v-visible-sr\">8 bronze badges</span>\r\n </div>\r\n </div>\r\n</div>\r\n </div>\r\n </div>\r\n</div>","tags":["ios","xcode","firebase","crashlytics"],"siteid":1,"noAnswers":true,"hasBounty":false,"fetch":false}"
}
""".data(using: .utf8)!
}
        
        var dummyData: Data {
            """
{
    "description": "<div class=\"goodsDesc js-navPanel\" id=\"anchorGoodsDesc\" name=\"anchorGoodsDesc\"> <h2 class=\"goodsDescribe_title\">\n                                                            Amazfit Pace Youtube Video Reviews\n                                                    </h2></div>"
}
""".data(using: .utf8)!
        }
        
        var dummyDataString = String(data: APIManager.productsData, encoding: .utf8)!
        var dummyDataString2 = (dummyDataString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        dummyDataString2 = (dummyDataString2 as NSString).replacingOccurrences(of: "\n", with: "")
        print(dummyDataString)
        print(dummyDataString2)
        let dummyData2 = dummyDataString2.data(using: .utf8)!
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: dummyData2, options: options, documentAttributes: nil) else {
            return
        }
        var decodedString = attributedString.string
        
        struct ABCD: Codable {
            let description: String
        }
        struct SocketResponse<T: Decodable>: Decodable {
            let action: String
            let data: T
        }
//
//
        struct Question: Decodable {
            let id: String
            let body: String
            let tags: [String]
            let siteid: Int
            let noAnswers: Bool
            let hasBounty: Bool
            let fetch: Bool
        }
//
//        let fileURL = Bundle.main.url(forResource: "SO", withExtension: "txt")
//        var responseStrr = String(data: jsonData, encoding: .utf8)!
//        var responseStr2 = try! String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
//
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\r\n", with: "")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\n", with: "")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\"{\"", with: "{\"")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "}\"}", with: "}}")
//
        decodedString = (decodedString as NSString).replacingOccurrences(of: "\r\n", with: "")
        decodedString = (decodedString as NSString).replacingOccurrences(of: "\n", with: "")
        decodedString = (decodedString as NSString).replacingOccurrences(of: "\"{\"", with: "{\"")
        decodedString = (decodedString as NSString).replacingOccurrences(of: "}\"}", with: "}}")
//
//
//        let responseDataa = responseStrr.data(using: .utf8)!
//
//        do {
//            let json = try JSONDecoder().decode(SocketResponse<Question>.self, from: responseData)
//            print("Success", json)
//        } catch {
//            print(error)
//        }
        
        let decoder = JSONDecoder()
        var responseStr = String(data: dummyData2, encoding: .utf8)!
        do {
            let res = try decoder.decode(SocketResponse<Question>.self, from: decodedString.data(using: .utf8)!)
            print(res)
        } catch {
            print(error)
        }
        
        do {
            let prod = try decoder.decode(ProductDetail.self, from: decodedString.data(using: .utf8)!)
            print(prod)
            var responseStr = String(data: APIManager.productsData, encoding: .utf8)

            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\r\n", with: "")
            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\n", with: "")
            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\"{\"", with: "{\"")
            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "}\"}", with: "}}")
            print(responseStr)
            if let responseData = responseStr?.data(using: .utf8) {
                let prod = try decoder.decode(ProductDetail.self, from: responseData)
                print(prod)
            }
            
        } catch {
            print(error)
        }
//
//        guard let data = responseStr.data(using: .utf8) else { return }
//        do {
//            let abcd = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil).trimmedAttributedString
//            print(abcd)
//        } catch {
//            print(error)
//        }
        
        
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\r\n", with: "")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\n", with: "")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "\"{\"", with: "{\"")
//        responseStr = (responseStr as NSString).replacingOccurrences(of: "}\"}", with: "}}")
//        let responseData = responseStr.data(using: .utf8)!
//        do {
//            let prod = try decoder.decode(ProductDetail.self, from: responseData)
//            print(prod)
//            var responseStr = String(data: APIManager.productsData, encoding: .utf8)
//
//            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\r\n", with: "")
//            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\n", with: "")
//            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "\"{\"", with: "{\"")
//            responseStr = (responseStr as NSString?)?.replacingOccurrences(of: "}\"}", with: "}}")
//            print(responseStr)
//            if let responseData = responseStr?.data(using: .utf8) {
//                let prod = try decoder.decode(ProductDetail.self, from: responseData)
//                print(prod)
//            }
//
//        } catch {
//            print(error)
//        }
//        urlSession.performRequest(
//            resource: .getProductDetail(by: productUrl),
//            success: { products in
//                success(products)
//            }, failure: { error in
//                failure(error)
//            }
//        )
    }
}

//extension APIManager: ListAPICommunicator {
//    func callListAPI(success: @escaping ((List) -> Void), failure: @escaping ((Error?) -> Void)) {
//        urlSession.performRequest(
//            resource: .getListData(),
//            success: { liveData in
//                DispatchQueue.main.async {
//                    success(liveData)
//                }
//            },
//            failure: { error in
//                failure(error)
//            }
//        )
//    }
//}


extension APIManager {


    static var productsData: Data {
       let jsonString = """
{
    "data_layer": {
        "PAGE": "goods",
        "PIPELINE": "GB",
        "LANG": "en",
        "google_tag_params": {
            "prodid": "221903202US",
            "pagetype": "product",
            "totalvalue": 109.14,
            "currency": "USD",
            "pcat": "Consumer Electronics > Smart Electronics > Smart Watches",
            "legal": 1
        },
        "CODE": "US",
        "goods": {
            "websku": "009348285739",
            "sku": "221903202",
            "cat_id": "11330",
            "nav_title_2": "Consumer Electronics",
            "nav_title_3": "Smart Electronics",
            "pic": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_100x100.jpg",
            "price": 109.14,
            "shopPrice": 109.14,
            "sn": "221903202US",
            "title": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
            "url": "https://www.gearbest.com/goods/pp_009348285739.html",
            "brand_code": "Amazfit"
        }
    },
    "options": [
        {
            "data-prime": "2",
            "name": "Black"
        },
        {
            "data-prime": "3",
            "name": "Bright Orange"
        },
        {
            "data-prime": "5",
            "name": "Global Version"
        }
    ],
    "option_links": [
        {
            "url": "https://www.gearbest.com/smart-watches/pp_687047.html?wid=1527929",
            "sale": 2,
            "platform": 1,
            "prime": 10,
            "webGoodSn": "009143384407",
            "virCode": "1527929",
            "goodSn": "221903201",
            "canBuy": 2
        },
        {
            "url": "https://www.gearbest.com/smart-watches/pp_689346.html?wid=1527929",
            "sale": 1,
            "platform": 1,
            "prime": 15,
            "webGoodSn": "009348285739",
            "virCode": "1527929",
            "goodSn": "221903202",
            "canBuy": 1
        }
    ],
    "good_info": {
        "title": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
        "goodsSn": "221903202",
        "webGoodsSn": "009348285739",
        "warehouseCode": "1527929",
        "isVirtual": "0",
        "shopPrice": "109.14",
        "appPrice": "109.14",
        "thumb": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_100x100.jpg",
        "thumbExtendUrl": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_220x220.jpg",
        "shopCode": "348",
        "pipelineCode": "GB",
        "goodsStatus": "2",
        "categoryId": "11330",
        "saleMark": "1",
        "brandCode": "Amazfit",
        "warehouseList": [
            {
                "code": "1527929",
                "name": "HK-4",
                "status": 1,
                "goodsStatus": 2,
                "whLogo": "ab"
            }
        ],
        "baseGoodsInfo": {
            "relateSizeChart": "",
            "brandName": "AMAZFIT",
            "recommendedLevel": 13,
            "limitPrice": "",
            "saleSizeLong": 14.6,
            "saleWeight": 0.26,
            "updateTime": "",
            "saleSizeHigh": 6,
            "limitType": "",
            "brandLink": "",
            "columeWeight": 0.26,
            "saleSizeWide": 12.6,
            "modelCode": "0",
            "sizeChart": "",
            "erpLevel": 6,
            "realityWeight": 0.26,
            "brandTitle": "Amazfit",
            "properties": "8",
            "brandCode": "Amazfit"
        },
        "recommendedLevel": "13",
        "ppExpressInfo": {
            "channelCode": "PP_Express",
            "ppMin": 1,
            "ppMax": 2500,
            "hide": false
        },
        "isShowAppPrice": "1",
        "goodsSpu": "2219032",
        "webGoodsSpu": "009105566",
        "isPlatform": "",
        "deliveryType": "",
        "shipTemplateId": "",
        "platformCategoryId": "",
        "backRuleId": []
    },
    "description": "<div class=\"goodsDesc js-navPanel\"><title>HTML Data</title></div>",
    "warehouse_data": [
        {
            "status": 0,
            "msg": "SUCCESS",
            "data": {
                "price": {
                    "userBuyLimit": "",
                    "advanceAmount": "",
                    "declare": "",
                    "isAdvance": "",
                    "groupId": "",
                    "stepPrice": "",
                    "currentVirtualOrder": "",
                    "finalEndTime": "",
                    "warehouseCode": "1527929",
                    "advanceStartTime": "",
                    "priceFact": "",
                    "deductionAmount": "",
                    "labelId": "-1",
                    "showNextInterval": "",
                    "finalAmount": "",
                    "price": 109.14,
                    "userLabelId": "",
                    "startTime": 0,
                    "virtualSaleQty": "",
                    "siteCode": "GB",
                    "finalStartTime": "",
                    "count": "",
                    "goodSn": "221903202",
                    "advanceEndTime": "",
                    "priceMd5": "A995762537446AB7A5B27C7732F7E94B",
                    "swellDiscontAmount": "",
                    "multipleIntervalsPrice": "",
                    "pricePage": "",
                    "userCount": 0,
                    "endTime": 0,
                    "saleQty": "",
                    "priceId": "1000000000000000000"
                },
                "stock": {
                    "can_buy": 1,
                    "stock": 1
                },
                "instalmentInfo": [],
                "goodsStatus": 2
            },
            "warehouse": "1527929"
        }
    ],
    "script_data": [
        {
            "@context": "http://schema.org/",
            "@type": "Product",
            "name": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
            "image": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg",
            "description": "Buy AMAZFIT Pace Heart Rate Sports Smartwatch Global Version at cheap price online, with Youtube reviews and FAQs, we generally offer free shipping to Europe, US, Latin America, Russia, etc.",
            "sku": "221903202",
            "mpn": "689346",
            "brand": {
                "@type": "Thing",
                "name": "mangrove"
            },
            "aggregateRating": {
                "@type": "AggregateRating",
                "ratingValue": "4.78",
                "reviewCount": "2706"
            },
            "offers": {
                "@type": "Offer",
                "url": "https://www.gearbest.com/smart-watches/pp_689346.html",
                "priceCurrency": "USD",
                "price": "109.14",
                "itemCondition": "http://schema.org/NewCondition",
                "availability": "http://schema.org/InStock",
                "seller": {
                    "@type": "Organization",
                    "name": "Gearbest"
                }
            }
        }
    ]
}
"""
        return jsonString.data(using: .utf8)!
    }
}


//extension APIManager {
//    static var pata: Data {
//       let jsonString = """
//[
//    {
//        "name": "Smart Electronics",
//        "level": 1,
//        "link": "/smart-electronics-c_12993/"
//    },
//    {
//        "name": "3D Printer & Supplies",
//        "level": 1,
//        "link": "/3d-printers-c_11340/"
//    },
//    {
//        "name": "Vacuums & Floor Care",
//        "level": 1,
//        "link": "/cleaning-supplies-c_12246/"
//    },
//    {
//        "name": "Scooters and Wheels",
//        "level": 1,
//        "link": "/scooters-and-wheels-c_12713/"
//    },
//    {
//        "name": "Shoes",
//        "level": 1,
//        "link": "/men-s-shoes-c_12131/"
//    },
//    {
//        "name": "Novel Coronavirus Prevention",
//        "level": 1,
//        "link": "/promotion-novel-coronavirus-supplies-special-8016.html"
//    },
//    {
//        "name": "Indoor Lights",
//        "level": 1,
//        "link": "/led-lights-c_11264/"
//    },
//    {
//        "name": "RC Drones & Vehicles",
//        "level": 1,
//        "link": "/remote-control-toys-c_12018/"
//    },
//    {
//        "name": "Kitchen & Dining",
//        "level": 1,
//        "link": "/kitchen-dining-c_11324/"
//    },
//    {
//        "name": "Car Electronics",
//        "level": 1,
//        "link": "/car-electronics-c_11927/"
//    },
//    {
//        "name": "Men's Watches",
//        "level": 1,
//        "link": "/men%27s-watches-c_12639/"
//    }
//]
//"""
//        return jsonString.data(using: .utf8)!
//    }
//}


//extension APIManager {
//    static var productDetailData2: Data {
//       let jsonString = """
//{
//    "data_layer": {
//        "PAGE": "goods",
//        "PIPELINE": "GB",
//        "LANG": "en",
//        "google_tag_params": {
//            "prodid": "221903202US",
//            "pagetype": "product",
//            "totalvalue": 109.14,
//            "currency": "USD",
//            "pcat": "Consumer Electronics > Smart Electronics > Smart Watches",
//            "legal": 1
//        },
//        "CODE": "US",
//        "goods": {
//            "websku": "009348285739",
//            "sku": "221903202",
//            "cat_id": "11330",
//            "nav_title_2": "Consumer Electronics",
//            "nav_title_3": "Smart Electronics",
//            "pic": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_100x100.jpg",
//            "price": 109.14,
//            "shopPrice": 109.14,
//            "sn": "221903202US",
//            "title": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
//            "url": "https://www.gearbest.com/goods/pp_009348285739.html",
//            "brand_code": "Amazfit"
//        }
//    },
//    "options": [
//        {
//            "data-prime": "2",
//            "name": "Black"
//        },
//        {
//            "data-prime": "3",
//            "name": "Bright Orange"
//        },
//        {
//            "data-prime": "5",
//            "name": "Global Version"
//        }
//    ],
//    "option_links": [
//        {
//            "url": "https://www.gearbest.com/smart-watches/pp_687047.html?wid=1527929",
//            "sale": 2,
//            "platform": 1,
//            "prime": 10,
//            "webGoodSn": "009143384407",
//            "virCode": "1527929",
//            "goodSn": "221903201",
//            "canBuy": 2
//        },
//        {
//            "url": "https://www.gearbest.com/smart-watches/pp_689346.html?wid=1527929",
//            "sale": 1,
//            "platform": 1,
//            "prime": 15,
//            "webGoodSn": "009348285739",
//            "virCode": "1527929",
//            "goodSn": "221903202",
//            "canBuy": 1
//        }
//    ],
//    "good_info": {
//        "title": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
//        "goodsSn": "221903202",
//        "webGoodsSn": "009348285739",
//        "warehouseCode": "1527929",
//        "isVirtual": "0",
//        "shopPrice": "109.14",
//        "appPrice": "109.14",
//        "thumb": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_100x100.jpg",
//        "thumbExtendUrl": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg_220x220.jpg",
//        "shopCode": "348",
//        "pipelineCode": "GB",
//        "goodsStatus": "2",
//        "categoryId": "11330",
//        "saleMark": "1",
//        "brandCode": "Amazfit",
//        "warehouseList": [
//            {
//                "code": "1527929",
//                "name": "HK-4",
//                "status": 1,
//                "goodsStatus": 2,
//                "whLogo": "ab"
//            }
//        ],
//        "baseGoodsInfo": {
//            "relateSizeChart": "",
//            "brandName": "AMAZFIT",
//            "recommendedLevel": 13,
//            "limitPrice": "",
//            "saleSizeLong": 14.6,
//            "saleWeight": 0.26,
//            "updateTime": "",
//            "saleSizeHigh": 6,
//            "limitType": "",
//            "brandLink": "",
//            "columeWeight": 0.26,
//            "saleSizeWide": 12.6,
//            "modelCode": "0",
//            "sizeChart": "",
//            "erpLevel": 6,
//            "realityWeight": 0.26,
//            "brandTitle": "Amazfit",
//            "properties": "8",
//            "brandCode": "Amazfit"
//        },
//        "recommendedLevel": "13",
//        "ppExpressInfo": {
//            "channelCode": "PP_Express",
//            "ppMin": 1,
//            "ppMax": 2500,
//            "hide": false
//        },
//        "isShowAppPrice": "1",
//        "goodsSpu": "2219032",
//        "webGoodsSpu": "009105566",
//        "isPlatform": "",
//        "deliveryType": "",
//        "shipTemplateId": "",
//        "platformCategoryId": "",
//        "backRuleId": []
//    },
//    "description": "<div class=\"goodsDesc js-navPanel\" id=\"anchorGoodsDesc\" name=\"anchorGoodsDesc\"> <h2 class=\"goodsDescribe_title\">\n                                                            Amazfit Pace Youtube Video Reviews\n                                                    </h2> <div class=\"goodsDesc_videoItem\" data-video-inline=\"NsPHWqHw9EA\"> <img class=\"goodsDesc_videoCover js-lazyload\" data-lazy=\"https://i.ytimg.com/vi/NsPHWqHw9EA/sddefault.jpg\" src=\"https://i.ytimg.com/vi/NsPHWqHw9EA/sddefault.jpg\"> <a class=\"goodsDesc_btnVideoPlay\" href=\"javascript:;\"> <svg height=\"48\" version=\"1.1\" viewbox=\"0 0 68 48\" width=\"68\"> <path class=\"ytp-large-play-button-bg\" d=\"M66.52,7.74c-0.78-2.93-2.49-5.41-5.42-6.19C55.79,.13,34,0,34,0S12.21,.13,6.9,1.55 C3.97,2.33,2.27,4.81,1.48,7.74C0.06,13.05,0,24,0,24s0.06,10.95,1.48,16.26c0.78,2.93,2.49,5.41,5.42,6.19 C12.21,47.87,34,48,34,48s21.79-0.13,27.1-1.55c2.93-0.78,4.64-3.26,5.42-6.19C67.94,34.95,68,24,68,24S67.94,13.05,66.52,7.74z\" fill=\"#212121\" fill-opacity=\"0.8\"></path> <path d=\"M 45,24 27,14 27,34\" fill=\"#fff\"></path> </svg> </a> </img></div> <div class=\"js-goodsDescribe\"> <h2 class=\"goodsDescribe_title\">\n                                                            Amazfit Pace Descriptions\n                                                    </h2> <link href=\"https://css.gbtcdn.com/css/gearbest_desc.css\" rel=\"stylesheet\" type=\"text/css\"/><div class=\"product_pz\"><h4 class=\"desc_title\"></h4><div class=\"product_pz_info mainfeatures desc_simp\"><b>Guide</b><br/>The AMAZFIT Running Smart Watch is a great choice for those looking to get fit. AMAZFIT features built-in GPS, so it provides accurate pace and distance for your runs, as well as an IP67 waterproof design that you can take swimming. It sports an unbelievable battery life for basic use.<br/><br/><b>Main Features:</b><br/>● Multiple sports recorders: track<b> running time, heart rate, pace, calories, speed, cadence, altitude, etc.</b><br/>● Well appointed communication tool: receive<b> incoming call, message, email, calendar, weather and notification of App</b><br/>● Excellent wristband performance: with<b> Alipay, GPS, phone-free music, IP67 waterproof</b><br/>●<b>Keep fitness in focus</b><br/>Get fit in style with AMAZFIT - this smart fitness watch helps you maximize every workout and every day. 24-hour continuous heart rate monitor automatically tracks your body condition and synchronize to the connected mobile phone<br/>Through the data youwill get a clear understanding of yourself. Multiple recording modes allow the watch to track your runs and capture distance, time, calories, altitude as well as maximum and average of pace, speed, cadence<br/>Its ability to use built-in GPS makes it far more accurate than your cellphone or other run tracking devices<br/>You are able to enjoy music and media with the internal storage for unencumbered phone-free running after connecting wireless to Bluetooth earphones<br/>●<b>Be your daily companion</b><br/>If you want to have notifications, fitness tracking and more on your wrist, AMAZFIT is a good value. The watch features smart notifications and vibration alerts for incoming calls, messages, <br/>emails and direct access to weather forecast, stopwatch, compass, alarms, and more. It also automatically tracks your daily steps, distance, calories and sleep quality. When you receive a call or message,<br/>you can receive right on your watch whether you're on the trail, on the golf course or simply away from your desk. You can also slide the screen to reject a call, convenient and effective <br/>With Alipay, you can complete payment via your smartphone ( <b>only the Chinese version support</b> ). The watch also supports the iOS and Android system, letting you take advantage of fitness features, notifications, and even Apps<br/><br/>●<b>Wear your temperament</b><br/>AMAZFIT is a model designed with ceramic bezel, making it durable and resistant to scratching. The always-on display allows reading easily even under bright sunlight<br/>Thanks to the IP67 waterproof, the item is resistant to dust, rain, splashing, and accidental submersion. With advanced technology in a versatile design, this revolutionary device even features WiFi connect ability<br/>You can enjoy music on your AMAZFIT Watch without your phone when you pair with Bluetooth headphones. With all this and more, AMAZFIT has everything you need to reach your goals<br/><br/><b>Buyers Guidelines:</b><br/>1. Be compatible with Bluetooth version 4.0, Android ( OS 4.4 or above ); for iPhone ( iOS 8.0 or above )<br/>2. IP67 waterproof means that stepping depth doesn't exceed one meter and steeping time doesn't exceed 30 minutes<br/>3. Please scan the QR code: <img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2017/05/04/1493878119244861.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2017/05/04/1493878119244861.jpg\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"><br/>or search \"AMAZFIT Watch\" at Apple Store or Android market to download the App<br/>4. The watch has two kinds of version for choosing: <b>English and Chinese</b><br/>( the difference between two versions is just the interface display and language of the user manual )<br/>5. Filling up the watch takes about 3 hours<br/>6. The WiFi distance is about 5 - 10m while Bluetooth works over a range of about 10 meters<br/>7. The watch has a 1.34-inch screen with 320 x 300 resolution and the dial thickness is 12mm<br/><br/><b>Tips:</b><br/>1. The watch does not need a SIM card, you just need to connect to your cell phone via Bluetooth.<br/>2. The watch's standby time is up to 11 days, working time is up to 5 days for regular use and 35 hours with continuous GPS tracking.<br/>3. The watch only supports to connect to one smartphone. If you want to rebind a new one, please unbind the original one first.<br/>4. The watch can't record the step number to the App synchronously, only read the steps on the watch.<br/>5. The time and date will be synced with your phone after App connected. Please check the device has been online in the App.     </img></div></div><div class=\"product_pz\"><h4 class=\"expand_en_name\">Specification</h4><div class=\"product_pz_info product_pz_style2\"><table><tr><th><p>General</p></th><td>             Brand: Amazfit                                                  <br>                                    Bluetooth Version: Bluetooth 4.0                                                  <br>                                    Operating mode: Touch Screen                                                  <br>                                    RAM: 512MB                                                  <br>                                    ROM: 4GB                                                  <br>                                    IP rating: IP67                                                          </br></br></br></br></br></td></tr><tr><th><p>Functions</p></th><td>             Alert type: Vibration                                                  <br>                                    Bluetooth calling: Phone call reminder                                                  <br>                                    Health tracker: Heart rate monitor,Pedometer                                                  <br>                                    Messaging: Message sending                                                  <br>                                    Other Function: Alarm,GPS,Weather forecast,WiFi                                                  <br>                                    Remote control function: Remote music                                                          </br></br></br></br></br></td></tr><tr><th><p>Battery</p></th><td>             Battery  Capacity: 280mAh                                                   <br>                                    Charging Time: About 3hours                                                  <br>                                    Standby time: 5 days                                                   <br>                                    Type of battery: Lithium Polymer Battery                                                           </br></br></br></td></tr><tr><th><p>Dial and Band</p></th><td>             Band material: Silicone                                                  <br>                                    Case material: Ceramic                                                  <br>                                    Shape of the dial: Round                                                  <br>                                    Dial size: 4.5 x 4.5 x 1.5 cm                                                  <br>                                    Band size: 24.5 x 3.5 cm                                                          </br></br></br></br></td></tr><tr><th><p>Features</p></th><td>             Compatible OS: Android,IOS                                                          </td></tr><tr><th><p>Dimensions and Weight</p></th><td>             Product weight: 0.1570 kg                                                  <br>                                    Package weight: 0.2600 kg                                                  <br>                                    Product size (L x W x H): 24.50 x 4.50 x 1.50 cm / 9.65 x 1.77 x 0.59 inches                                                  <br>                                    Package size (L x W x H): 14.60 x 12.60 x 6.00 cm / 5.75 x 4.96 x 2.36 inches                                                          </br></br></br></td></tr><tr><th><p>Package Contents</p></th><td>             Package Contents: 1 x Original AMAZFIT Sports Smart Watch, 1 x USB Charging Cable, 1 x English User Manual                                                           </td></tr></table></div></div><p><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_12686.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_12686.jpg\" style=\"max-width: 1000px;\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"><br/></img></p><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112948_64373.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112948_64373.jpg\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><p><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_55213.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_55213.jpg\" style=\"white-space: normal; max-width: 1000px;\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></p><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112949_32701.gif\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112949_32701.gif\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><p><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_25680.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2019/07/25/20190725105614_25680.jpg\" style=\"white-space: normal; max-width: 1000px;\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></p><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112950_17303.gif\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112950_17303.gif\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112951_60079.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112951_60079.jpg\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112953_41681.gif\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112953_41681.gif\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112953_97388.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112953_97388.jpg\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><div class=\"self-adaption\"><img alt=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\" class=\"js-descLazyload\" data-lazy=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112954_24827.jpg\" src=\"https://des.gbtcdn.com/uploads/pdm-desc-pic/Electronic/image/2018/12/14/20181214112954_24827.jpg\" style=\"max-width:1000px\" title=\"AMAZFIT Sports Smartwatch Bluetooth 4.0 Heart Rate Monitor GPS Pedometer - Bright Orange Global Version\"/></div><p><br><br><br/></br></br></p> </div> </div>",
//    "warehouse_data": [
//        {
//            "status": 0,
//            "msg": "SUCCESS",
//            "data": {
//                "price": {
//                    "userBuyLimit": "",
//                    "advanceAmount": "",
//                    "declare": "",
//                    "isAdvance": "",
//                    "groupId": "",
//                    "stepPrice": "",
//                    "currentVirtualOrder": "",
//                    "finalEndTime": "",
//                    "warehouseCode": "1527929",
//                    "advanceStartTime": "",
//                    "priceFact": "",
//                    "deductionAmount": "",
//                    "labelId": "-1",
//                    "showNextInterval": "",
//                    "finalAmount": "",
//                    "price": 109.14,
//                    "userLabelId": "",
//                    "startTime": 0,
//                    "virtualSaleQty": "",
//                    "siteCode": "GB",
//                    "finalStartTime": "",
//                    "count": "",
//                    "goodSn": "221903202",
//                    "advanceEndTime": "",
//                    "priceMd5": "A995762537446AB7A5B27C7732F7E94B",
//                    "swellDiscontAmount": "",
//                    "multipleIntervalsPrice": "",
//                    "pricePage": "",
//                    "userCount": 0,
//                    "endTime": 0,
//                    "saleQty": "",
//                    "priceId": "1000000000000000000"
//                },
//                "stock": {
//                    "can_buy": 1,
//                    "stock": 1
//                },
//                "instalmentInfo": [],
//                "goodsStatus": 2
//            },
//            "warehouse": "1527929"
//        }
//    ],
//    "script_data": [
//        {
//            "@context": "http://schema.org/",
//            "@type": "Product",
//            "name": "AMAZFIT Pace Heart Rate Sports Smartwatch Global Version",
//            "image": "https://gloimg.gbtcdn.com/images/pdm-product-pic/Electronic/2017/08/05/source-img/20170805150544_31984.jpg",
//            "description": "Buy AMAZFIT Pace Heart Rate Sports Smartwatch Global Version at cheap price online, with Youtube reviews and FAQs, we generally offer free shipping to Europe, US, Latin America, Russia, etc.",
//            "sku": "221903202",
//            "mpn": "689346",
//            "brand": {
//                "@type": "Thing",
//                "name": "mangrove"
//            },
//            "aggregateRating": {
//                "@type": "AggregateRating",
//                "ratingValue": "4.78",
//                "reviewCount": "2706"
//            },
//            "offers": {
//                "@type": "Offer",
//                "url": "https://www.gearbest.com/smart-watches/pp_689346.html",
//                "priceCurrency": "USD",
//                "price": "109.14",
//                "itemCondition": "http://schema.org/NewCondition",
//                "availability": "http://schema.org/InStock",
//                "seller": {
//                    "@type": "Organization",
//                    "name": "Gearbest"
//                }
//            }
//        }
//    ]
//}
//"""
//        return jsonString.data(using: .utf8)!
//    }
//}
