//
//  RoomType.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

struct RoomType: Codable{
  var id: String
  var name: String
//  var shortName: String
//  var price: Int
    
    // , shortName: String = "Not Set", price: Int = 0
  init(id: String = "", name: String = "点击设置"){
    self.id = id
    self.name = name
//    self.shortName = shortName
//    self.price = price
  }
}
extension RoomType: Equatable{
  static func == (lhs: RoomType, rhs: RoomType) -> Bool{
    return lhs.id == rhs.id
  }
}
extension RoomType{
  static var all: [RoomType]{
    return [
//      RoomType(id: 1, name: "Standard", shortName: "St", price: 109),
//      RoomType(id: 2, name: "Superior", shortName: "Sp", price: 159),
//      RoomType(id: 3, name: "Suite", shortName: "Si", price: 209),
//      RoomType(id: 4, name: "King Suite", shortName: "KS", price: 259),
//      RoomType(id: 5, name: "Family room", shortName: "FR", price: 309),
//      RoomType(id: 6, name: "Apartments", shortName: "APR", price: 389),
//      RoomType(id: 7, name: "Run of house", shortName: "ROH", price: 99)
        
        RoomType(id: "1", name: "北京"),
        RoomType(id: "2", name: "福州"),
    ]
  }
}
