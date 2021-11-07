//
//  TimetableEditViewController.swift
//  NewsApp
//
//  Created by user on 30.10.2021.
//

import Foundation
import UIKit

enum TimetableEditVCMode {
    case edit
    case add
}

class TimetableEditViewController: UIViewController {
    
    @IBOutlet private var groupNameLabel: UILabel!
    @IBOutlet private var groupNameTextField: UITextField!
    
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var dayTextField: UITextField!
    
    @IBOutlet private var timeLabel: UILabel!
    
    @IBOutlet private var beginTimeHoursTextField: UITextField!
    @IBOutlet private var beginTimeColonLabel: UILabel!
    @IBOutlet private var beginTimeMinutesTextField: UITextField!
    
    @IBOutlet private var timeDashLabel: UILabel!

    @IBOutlet private var endTimeHoursTextField: UITextField!
    @IBOutlet private var endTimeColonLabel: UILabel!
    
    @IBOutlet private var endTimeMinutesTextField: UITextField!
    
    @IBOutlet private var trainerLabel: UILabel!
    @IBOutlet private var trainerTextField: UITextField!
    
    @IBOutlet private var saveButton: UIButton!
    
    private var pickerView: UIPickerView?
    
    private var weekDays = WeekDays.allCases
    private var groupNames = GroupNames.allCases
    
    private var hours: [String] = []
    private var minutes: [String] = []
    
    private var selectedTextField = UITextField()
    private var changedTimetable: TimetableModel? = nil
    private var successChanges: [String: Bool] = ["groupName": false, "day": false, "beginHours": false, "beginMinutes": false, "endHours": false, "endMinutes": false, "trainer": false]
    
    public var timetable: TimetableModel? = nil
    public var completionHandler: ((TimetableModel?) -> ())?
    public var mode: TimetableEditVCMode = .edit
    
    @IBAction private func tapSaveButton(_ sender: Any) {
        if mode == .edit {
            completionHandler?(changedTimetable)
        } else {
            completionHandler?(timetable)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        if let model = timetable {
            self.navigationItem.title = model.day.rawValue.capitalized + " " + model.timeInterval.getString()
        }
        groupNameTextField.delegate = self
        dayTextField.delegate = self
        beginTimeHoursTextField.delegate = self
        beginTimeMinutesTextField.delegate = self
        endTimeHoursTextField.delegate = self
        endTimeMinutesTextField.delegate = self
        trainerTextField.delegate = self
        hours = getTimeArray(count: 23)
        minutes = getTimeArray(count: 59)
        setupPickerView()
        setupSaveButton(enabled: false)
        if mode == .edit {
            setupInfo()
            changedTimetable = timetable
        } else {
            timetable = TimetableModel(day: .monday, timeInterval: TimeInterval(begin: Time(hours: "", minutes: ""), end: Time(hours: "", minutes: "")), groupName: .np1, trainer: "")
        }
    }

    private func setupPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        groupNameTextField.inputView = pickerView
        dayTextField.inputView = pickerView
        beginTimeHoursTextField.inputView = pickerView
        beginTimeMinutesTextField.inputView = pickerView
        endTimeHoursTextField.inputView = pickerView
        endTimeMinutesTextField.inputView = pickerView
        self.pickerView = pickerView
    }
    
    private func setupInfo() {
        guard let model = timetable else { return }
        groupNameTextField.text = model.groupName.rawValue
        dayTextField.text = model.day.rawValue
        beginTimeHoursTextField.text = model.timeInterval.begin.hours
        beginTimeMinutesTextField.text = model.timeInterval.begin.minutes
        endTimeHoursTextField.text = model.timeInterval.end.hours
        endTimeMinutesTextField.text = model.timeInterval.end.minutes
        trainerTextField.text = model.trainer
    }
    
    private func getTimeArray(count: Int) -> [String] {
        guard count > 0 else { return [] }
        var array: [String] = []
        for i in 0...count {
            if i<=9 {
                array.append("0" + String(i))
            } else {
                array.append(String(i))
            }
        }
        return array
    }
    
    private func getPickerViewTitle(row: Int) -> String? {
        switch selectedTextField {
        case groupNameTextField:
            return groupNames[row].rawValue
        case dayTextField:
            return weekDays[row].rawValue
        case beginTimeHoursTextField, endTimeHoursTextField:
            return hours[row]
        case beginTimeMinutesTextField, endTimeMinutesTextField:
            return minutes[row]
        default: return nil
        }
    }
    
    private func getPickerViewNumberOfRows() -> Int {
        switch selectedTextField {
        case groupNameTextField:
            return groupNames.count
        case dayTextField:
            return weekDays.count
        case beginTimeHoursTextField, endTimeHoursTextField:
            return hours.count
        case beginTimeMinutesTextField, endTimeMinutesTextField:
            return minutes.count
        default: return 0
        }
        
    }
    
    private func getPickerViewSelectRow() -> Int {
        guard let text = selectedTextField.text, !text.isEmpty else { return 0 }

        switch selectedTextField {
        case groupNameTextField:
            if let groupName = GroupNames(rawValue: text) {
                return groupNames.firstIndex(of: groupName) ?? 0
            }
        case dayTextField:
            if let day = WeekDays(rawValue: text) {
                return weekDays.firstIndex(of: day) ?? 0
            }
        case beginTimeHoursTextField, endTimeHoursTextField:
            return hours.firstIndex(of: text) ?? 0
        case beginTimeMinutesTextField, endTimeMinutesTextField:
            return hours.firstIndex(of: text) ?? 0
        default: break
        }
        return 0
    }
    
    private func hasChangedEdit() -> Bool {
        guard let model = timetable, var changedModel = changedTimetable else { return false }
        
        switch selectedTextField {
        case groupNameTextField:
            if let groupName = GroupNames(rawValue: groupNameTextField.text ?? "") {
                changedModel.groupName = groupName
            }
        case dayTextField:
            if let day = WeekDays(rawValue: dayTextField.text ?? "") {
                changedModel.day = day
            }
        case beginTimeHoursTextField:
            changedModel.timeInterval.begin.hours = beginTimeHoursTextField.text ?? "00"
        case beginTimeMinutesTextField:
            changedModel.timeInterval.begin.minutes = beginTimeMinutesTextField.text ?? "00"
        case endTimeHoursTextField:
            changedModel.timeInterval.end.hours = endTimeHoursTextField.text ?? "00"
        case endTimeMinutesTextField:
            changedModel.timeInterval.end.minutes = endTimeMinutesTextField.text ?? "00"
        case trainerTextField:
            changedModel.trainer = trainerTextField.text ?? ""
        default: break
        }
        self.changedTimetable = changedModel
        return !(model == changedModel)
    }
    
    private func hasChangedAdd() -> Bool {
        //guard let model = timetable, var changedModel = changedTimetable else { return false }
        switch selectedTextField {
        case groupNameTextField:
            if let text = groupNameTextField.text, let groupName = GroupNames(rawValue: text) {
                timetable?.groupName = groupName
                successChanges["groupName"] = true
            } else {
                successChanges["groupName"] = false
            }
        case dayTextField:
            if let text = dayTextField.text, let day = WeekDays(rawValue: text) {
                timetable?.day = day
                successChanges["day"] = true
            } else {
                successChanges["day"] = false
            }
        case beginTimeHoursTextField:
            if let text = beginTimeHoursTextField.text, !text.isEmpty {
                timetable?.timeInterval.begin.hours = text
                successChanges["beginHours"] = true
            } else {
                successChanges["beginHours"] = false
            }
        case beginTimeMinutesTextField:
            if let text = beginTimeMinutesTextField.text, !text.isEmpty {
                timetable?.timeInterval.begin.minutes = text
                successChanges["beginMinutes"] = true
            } else {
                successChanges["beginMinutes"] = false
            }
        case endTimeHoursTextField:
            if let text = endTimeHoursTextField.text, !text.isEmpty {
                timetable?.timeInterval.end.hours = text
                successChanges["endHours"] = true
            } else {
                successChanges["endHours"] = false
            }
        case endTimeMinutesTextField:
            if let text = endTimeMinutesTextField.text, !text.isEmpty {
                timetable?.timeInterval.end.minutes = text
                successChanges["endMinutes"] = true
            } else {
                successChanges["endMinutes"] = false
            }
        case trainerTextField:
            if let text = trainerTextField.text, !text.isEmpty {
                timetable?.trainer = text
                successChanges["trainer"] = true
            } else {
                successChanges["trainer"] = false
            }
        default: break
        }
        
        for item in successChanges {
            if !item.value {
                return false
            }
        }
        return true
    }
    
    private func setupSaveButton(enabled: Bool) {
        saveButton.isEnabled = enabled
    }
}

extension TimetableEditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        getPickerViewNumberOfRows()
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        getPickerViewTitle(row: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedTextField.text = getPickerViewTitle(row: row)
    }
    
}

extension TimetableEditViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
        pickerView?.reloadAllComponents()
        let selectRow = getPickerViewSelectRow()
        pickerView?.selectRow(selectRow, inComponent: 0, animated: false)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if mode == .edit {
            setupSaveButton(enabled: hasChangedEdit())
        } else {
            setupSaveButton(enabled: hasChangedAdd())
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == trainerTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}

