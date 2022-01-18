import Foundation

// MARK: - RootClassElement
struct RootClassElement: Codable {
    var id: Int?
    var name, username, email: String?
    var profileImage: String?
    var address: Address?
    var phone, website: String?
    var company: Company?

    enum CodingKeys: String, CodingKey {
        case id, name, username, email
        case profileImage = "profile_image"
        case address, phone, website, company
    }
}

// MARK: - Address
struct Address: Codable {
    var street, suite, city, zipcode: String?
    var geo: Geo?
}

// MARK: - Geo
struct Geo: Codable {
    var lat, lng: String?
}

// MARK: - Company
struct Company: Codable {
    var name, catchPhrase, bs: String?
}

typealias RootClass = [RootClassElement]
