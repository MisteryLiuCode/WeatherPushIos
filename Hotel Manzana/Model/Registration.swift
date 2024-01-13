//
//  Registration.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

import Foundation
struct Registration: Codable {
  var recName: String
  var recPhone: String
  var emailAdress: String
  var emailPassword: String

  var checkInDate: String
//  var numberOfAdults: Int
//  var numberOfChildren: Int

  var roomType: RoomType?
  var status: Bool
  init(recName: String = "",
       recPhone: String = "",
       emailAdress: String = "",
       emailPassword: String = "",
       checkInDate: String = "",
//       checkOutDate: Date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(60 * 60 * 24),
//       numberOfAdults: Int = 1,
//       numberOfChildren: Int = 0,
       roomType: RoomType? = nil,
       status: Bool = false) {
    self.recName = recName
    self.recPhone = recPhone
    self.emailAdress = emailAdress
    self.emailPassword = emailPassword
    self.checkInDate = checkInDate
//    self.numberOfAdults = numberOfAdults
//    self.numberOfChildren = numberOfChildren
    self.roomType = roomType
    self.status = status
  }
}

extension Registration {
  static var sample: [Registration]{
    return [
//      Registration(recName: "John", recPhone: "Doe", emailAdress: "johndoe@unknown.com", checkInDate: .now, checkOutDate: .now.addingTimeInterval(60 * 60 * 24), numberOfAdults: 1, numberOfChildren: 0, roomType: RoomType(id: 1, name: "Standard", shortName: "St", price: 109), status: true),
//      Registration(recName: "Jane", recPhone: "Doe", emailAdress: "janedoe@comfortablynumb.org", checkInDate: .now, checkOutDate: .now.addingTimeInterval(60 * 60 * 24), numberOfAdults: 1, numberOfChildren: 1, roomType: RoomType(id: 2, name: "Superior", shortName: "Sp", price: 159), status: true),
//      Registration(recName: "Joe", recPhone: "Average", emailAdress: "avaragejoe@thereisnospoon.edu", checkInDate: .now, checkOutDate: .now.addingTimeInterval(60 * 60 * 24), numberOfAdults: 1, numberOfChildren: 0, roomType: RoomType(id: 7, name: "Run of house", shortName: "ROH", price: 99), status: false),
        Registration(recName: "刘帅彪", recPhone: "18539055863", emailAdress: "misteryliu@outlook.com", checkInDate: "",roomType: RoomType(id: "1", name: "北京"), status: true),
    ]
  }

  static func loadSample() -> [Registration]{
    return sample
  }
}

