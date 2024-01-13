//
//  CellManager.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 02.12.2021.
//

import UIKit

/// Manages custom cell of GuestsTableViewController
class CellManager{
    // 给每个cell赋值
  func configure(_ cell: GuestCell, witn guest: Registration){
    cell.recNameLabel.text = guest.recName
    cell.recPhoneLabel.text = guest.recPhone
    cell.roomTypeLabel.text = guest.roomType?.name
  }
}
