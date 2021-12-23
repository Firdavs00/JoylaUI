
import Foundation


struct PageData: Codable, Equatable {
    var id: Int?
    var category: Category?
    var name: String?
    var description: String?
    var productState: String?
    var status: String?
    var lang: Double?
    var lat: Double?
    var images: [ProductImage]?
    var productParams: [ProductParam]?
    var productPrice: ProductPrice?
    var district: District?
    var createdAt: String?
    var createdBy: Int?
    var phone: String?
    var numberHidden: Bool?
    var chatId: Int?
    var offerId: Int?
    var favorite: Bool?
    var user: User?
    var viewCount: Int?
    var quantity: Int?
}

struct User: Codable, Equatable {
    var id: Int?
    var firstName: String?
    var avatarId: String?
    var avatarPath: String?
}

struct ProductPreviewModel  {
    let title: String?
    let description: String?
    let price: String?
//    let previewImage: [UIImage?]?
    let currencyType: String?
    let categoryType: String?
    let features: ProductParam?
}
struct District: Codable, Equatable {
    let id: Int?
    let name: String?
    let regionName: String?
}
struct ProductPrice: Codable, Equatable {
    let id: Int?
    let price: Double?
    let sale: Double?
    let currencyType: String?
    let currencyRate: Double?
    let productID: Int?
}

struct ProductParam: Codable, Equatable {
    let id: Int?
    let name: String?
    let params: [ProductParams]?
}

struct ProductParams: Codable, Equatable {
    let id: Int?
    let productId: Int?
    let paramId: Int?
    let groupId: Int?
    let name: String?
    let type: String?
    let value: String?
    let unit: String?
    let paramValues: [ParamValues]?
}

struct ParamValues: Codable, Equatable {
    let id: Int?
    let name: String?
    let paramId: Int?
}

struct ProductImage: Codable, Equatable {
    var id: String?
    let productId: Int?
    let path: String?
    var url: String?
    let width: Double?
    let height: Double?
    let contentType: String?
    let index: Int?
    let isMain: Bool?
    let orientation: String?
}

struct ProductSortedParams {
    let name: String
    let value: String
}

struct Category: Codable, Equatable, Hashable {
    let id: ID
    let name: String?
    let parentId: Int?
    let rate: Int?
    let createdAt: String?
    let createdBy: Int?
    let productCount: Int?
    let childrenCount: Int?
    let isParent: Bool?
    let photoId: String?
    
    typealias ID = Int
}
enum CurrencyType: String, Codable {
    case usd = "c"
    case sum = "SUM"
}
enum ImageMode: String, Codable {
    case portrait = "PORTRAIT"
    case square = "SQUARE"
    case landscape = "LANDSCAPE"
}
enum ProductState: String, Codable {
    case old = "OLD"
    case new = "NEW"
    case used = "USED"
}
