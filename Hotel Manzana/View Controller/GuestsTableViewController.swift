//
//  GuestsTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 02.12.2021.
//

import UIKit
import Alamofire

class GuestsTableViewController: UITableViewController {
  // MARK: - Properties
    // 创建对象
  let cellManager = CellManager()
  let dataManager = DataManager()
    // 声明guest数组，数组的值是 Registration
    // didSet值的是如果guests发生变化，则调用dataManager.saveListOfGuests(guests)更新数据
  var guests: [Registration]! {
    didSet{
      dataManager.saveListOfGuests(guests)
    }
  }


  //MARK: - UIViewController Methods
    // 打开这个页面时主动调用
  override func viewDidLoad() {
    super.viewDidLoad()
      // 加载数据，如果加载不到，则加载loadSample，写死的数据
    guests = dataManager.loadGuests() ?? Registration.loadSample()
      // 指定 navigationItem左边的按钮是编辑按钮
    navigationItem.leftBarButtonItem = editButtonItem
  }

//MARK: - Navigation
    // 在页面显示之前调用
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard segue.identifier == "EditSegue" else { return }
    guard let selectedPath = tableView.indexPathForSelectedRow else { return }
    let guest = guests[selectedPath.row]
    let destination = segue.destination as! AddRegistrationTableViewController
    destination.guest = guest
  }

}
//MARK: - UITableViewDataSourse methods

extension GuestsTableViewController/*:UITableViewDataSourse*/ {
    // 设置行数
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return guests.count
  }

    // 配置制定位置的单元格
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let guest = guests[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "GuestCell")! as! GuestCell
      //给cell赋值
    cellManager.configure(cell, witn: guest)
      // 如果 roomType.id == 1 则单元格背景色为红色
//    if guest.roomType?.id == "1" { cell.backgroundColor = .red }
    return cell
  }

    // 删除一行
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let movedGuest = guests.remove(at: sourceIndexPath.row)
    guests.insert(movedGuest, at: destinationIndexPath.row)
  }
}

//MARK: - UITableViewDelegate methods
extension GuestsTableViewController/*: UITableViewDelegate*/ {
    // 在编辑模式下，用户看到每一行都可以删除，这里可以做逻辑判断，制定某些内容不可删除
  override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    return .delete
  }
    //
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle{
    case .delete:
        // 删除元素
      guests.remove(at: indexPath.row)
      tableView.deleteRows(at: [indexPath], with: .fade)
    case .insert:
      break
    case .none:
      break
    @unknown default:
      print (#line, #function, "Unknown case!")
      break
    }
  }
}

//MARK: - Actions
extension GuestsTableViewController {
    // 保存
  @IBAction func unwind(_ segue: UIStoryboardSegue) {
    guard segue.identifier == "doneSegue" else { return }
    let source = segue.source as! AddRegistrationTableViewController
    let guest = source.guest
      // 定义请求的URL
          let url = "http://localhost:49030/user/saveRecUserInfo"
      
      // 修改
    if let selectedPath = tableView.indexPathForSelectedRow {
        // 创建请求体对象
        var parameters: [String: Any] = [
            "recName": guest.recName,
            "recEmail": guest.emailAdress,
            "recPhone": guest.recPhone,
            "recTime": guest.checkInDate,
            "cityCode": guest.roomType?.id,
            "cityName": guest.roomType?.name,
            // 0 添加,1修改
            "insertOrUpdate": "1"
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        // 处理成功的响应
                        print("Response JSON: \(value)")
                    case .failure(let error):
                        // 处理请求失败的情况
                        print("Error: \(error)")
                    }
                }
      guests[selectedPath.row] = guest
      tableView.reloadRows(at: [selectedPath], with: .automatic)
    } else {
        // 添加
        // 创建请求体对象
        var parameters: [String: Any] = [
            "recName": guest.recName,
            "recEmail": guest.emailAdress,
            "recPhone": guest.recPhone,
            "recTime": "111",
            "cityCode": "123",
            "cityName": "123",
            // 0 添加,1修改
            "insertOrUpdate": "0"
        ]
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        // 处理成功的响应
                        print("Response JSON: \(value)")
                    case .failure(let error):
                        // 处理请求失败的情况
                        print("Error: \(error)")
                    }
                }
      let indexPath = IndexPath(row: guests.count, section: 0)
      guests.append(guest)
      tableView.insertRows(at: [indexPath], with: .automatic)
    }
  }
}
