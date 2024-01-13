//
//  AddRegistrationTableViewController.swift
//  Hotel Manzana
//
//  Created by Николай Никитин on 21.11.2021.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {

  // MARK: - Outlets
    // 保存按钮
  @IBOutlet weak var doneBarButton: UIBarButtonItem!

    // 接收昵称
  @IBOutlet var recNameTextField: UITextField!
    // 接收电话
  @IBOutlet var recPhoneTextField: UITextField!
    // 邮箱地址
  @IBOutlet var emailAdressTextField: UITextField!
    // 日期显示label
  @IBOutlet var checkInDateLabel: UILabel!
    // 日期选择器
  @IBOutlet var checkInDatePicker: UIDatePicker!

    // 状态打开关闭组件
  @IBOutlet var statusSwitch: UISwitch!
    // roomType显示组件
  @IBOutlet var roomTypeLabel: UILabel!

  // MARK: - Properties
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.locale = Locale.current
    return dateFormatter
  }()
  let checkInDateLabelIndexPath = IndexPath(row: 0, section: 1)
  let checkInDatePickerIndexPath = IndexPath(row: 1, section: 1)
  let checkOutDatePickerIndexPath = IndexPath(row: 3, section: 1)
  var isCheckInDatePickerShown: Bool = false{
    didSet {
      checkInDatePicker.isHidden = !isCheckInDatePickerShown
    }
  }

  let midnightToday = Calendar.current.startOfDay(for: Date())
  var roomType: RoomType?
  var guest = Registration()

  //MARK: - UIViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldWatcher()
    checkInDatePicker.minimumDate = midnightToday
    checkInDatePicker.date = midnightToday
    updateDateViews()
    updateUI()
    updateRoomType()
  }

  //MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    if (segue.identifier == "SelectRoomType"){
      let destination = segue.destination as! SelectRoomTypeTableViewController
      destination.delegate = self
      destination.roomType = roomType
    } else if (segue.identifier == "doneSegue") {
      saveGuestData()
    }
  }

  //MARK: - UI Methods
  private func updateUI(){
      recNameTextField.text = guest.recName
    recPhoneTextField.text = guest.recPhone
    emailAdressTextField.text = guest.emailAdress
      checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
    roomTypeLabel.text = guest.roomType?.name ?? "Not Set"
    self.roomType = guest.roomType
      statusSwitch.isOn = guest.status
  }

  private func saveGuestData(){
    let recName = recNameTextField.text ?? ""
    let recPhone = recPhoneTextField.text ?? ""
    let email = emailAdressTextField.text ?? ""
      let recTime = checkInDateLabel.text ?? ""
    let status = statusSwitch.isOn
    guest = Registration(
        recName: recName,
        recPhone: recPhone,
      emailAdress: email,
        checkInDate: recTime,
      roomType: roomType,
        status: status
    )
  }

  private func updateDateViews(){
      let timeFormatter = DateFormatter()
      timeFormatter.dateFormat = "HH:mm"
      let time = timeFormatter.string(from: checkInDatePicker.date)
      checkInDateLabel.text = timeFormatter.string(from: checkInDatePicker.date)
  }

  private func updateRoomType(){
    if let roomType = roomType {
      roomTypeLabel.text = roomType.name
    } else {
      roomTypeLabel.text = "Not Set"
    }
  }

  private func isEmailValid() -> Bool{
    guard let text = emailAdressTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return false }
    guard let emailDetection = try? NSDataDetector (types: NSTextCheckingResult.CheckingType.link.rawValue) else { return false }
    let range = NSMakeRange(0, NSString(string: text).length)
    let matches = emailDetection.matches(in: text, options: [], range: range)
    if matches.count == 1, matches.first?.url?.absoluteString.contains("mailto:") == true {
      return true
    }
    return false
  }

  private func textFieldWatcher(){
      recNameTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
      recPhoneTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    emailAdressTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
  }

  @objc func textFieldDidChange(_ textField: UITextField){
    if (recNameTextField.text!.isEmpty || recPhoneTextField.text!.isEmpty || emailAdressTextField.text!.isEmpty || !isEmailValid() || self.roomType == nil) {
      doneBarButton.isEnabled = false
    } else {
      doneBarButton.isEnabled = true
    }
  }

  //MARK: - Actions
  @IBAction func datePickerValueChahged(_ sender: UIDatePicker){
    updateDateViews()
  }
}


// MARK: - UITableViewDataSource
extension  AddRegistrationTableViewController /*: UITableViewDataSource */{
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath {
    case checkInDatePickerIndexPath:
      return isCheckInDatePickerShown ? UITableView.automaticDimension : 0
    default:
      return UITableView.automaticDimension
    }
  }
}

//MARK: - UITableViewDelegate
extension AddRegistrationTableViewController/*: UITableViewDelegate */{
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath {
    case checkInDateLabelIndexPath:
      isCheckInDatePickerShown.toggle()
    default:
      return
    }
    tableView.reloadData()
  }
}

//MARK: - SelectRoomTypeTableViewControllerProtocol
extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerProtocol{
  func didSelect(roomType: RoomType) {
    self.roomType = roomType
    updateRoomType()
  }
}

