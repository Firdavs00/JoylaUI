


import Foundation
import Alamofire
import SwiftUI
//http://18.189.232.65/mobile/api/products?user_lat=41.310804&user_lang=69.280934&page=7&size=30

private let IS_TESTER = true
private let DEP_SER = "http://18.189.232.65/mobile/"
private let DEV_SER = "http://18.189.232.65/mobile/"
// http://18.189.232.65/mobile/api/products/
let headers: HTTPHeaders = [
    "Accept": "application/json",
]

class AFHttp {
    
    // MARK : - AFHttp Requests
    
    class func get(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .get, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func post(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .post, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func put(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .put, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func del(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .delete, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    // MARK : - AFHttp Methods
    class func server(url: String) -> URL{
        if(IS_TESTER){
            return URL(string: DEV_SER + url)!
        }
        return URL(string: DEP_SER + url)!
    }
    
    // MARK : - AFHttp Apis
 
//    static let API_GET_PRODUCTS = "api/products?user_lat=41.310804&user_lang=69.280934&page=7&size=30"
    static let API_GET_DETAIL = "api/products/" //id
    static let API_POST_CREATE = "posts"
    static let API_POST_UPDATE = "posts/" //id
    static let API_POST_DELETE = "posts/" //id
    
    
    // MARK : - AFHttp Params
    class func paramsEmpty() -> Parameters {
        let parameters: Parameters = [
            :]
        return parameters
    }
    
//    class func paramsPostCreate(post: Post) -> Parameters {
//        let parameters: Parameters = [
//            "title": post.title!,
//            "body": post.body!,
//            "userId": post.userId!,
//        ]
//        return parameters
//    }
//
//    class func paramsPostUpdate(post: Post) -> Parameters {
//        let parameters: Parameters = [
//            "id": post.id!,
//            "title": post.title!,
//            "body": post.body!,
//            "userId": post.userId!,
//        ]
//        return parameters
//    }
    
}
//var request = URLRequest(url: URL(string: "\(Constants.base_url)/api/products?&user_lat=\(locationManager.lastLocation?.coordinate.latitude ?? 41.310804)&user_lang=\(locationManager.lastLocation?.coordinate.longitude ?? 69.280934)&more_like_this=true&category_id=\(catId)&size=6")!)
//http://18.189.232.65/mobile/api/products?user_lat=41.310804&user_lang=69.280934&more_like_this=true&category_id=4&size=6
