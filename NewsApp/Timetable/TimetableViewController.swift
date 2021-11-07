//
//  TimetableViewController.swift
//  NewsApp
//
//  Created by user on 17.10.2021.
//

import Foundation
import UIKit

class TimetableViewController: UIViewController {
    
    @IBOutlet private var timetableTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var timetableList: [TimetableModel] = []
    var filteredTimetableList: [TimetableModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = addButton
        searchBar.delegate = self
        greateTimetable()
        setupTableView()
        filteredTimetableList = timetableList
    }
    
    @objc func addButtonPressed(sender: AnyObject) {
        guard let timetableEditVC = UIStoryboard.timetableEdit.instantiateViewController(withIdentifier: "\(TimetableEditViewController.self)") as? TimetableEditViewController else { return }
        //timetableEditVC.timetable = nil
        timetableEditVC.mode = .add
        timetableEditVC.completionHandler = { [weak self] timetable in
            if let model = timetable {
                
                self?.timetableList.append(model)
                if let list = self?.timetableList {
                    self?.filteredTimetableList = list
                }
                DispatchQueue.main.async{
                    self?.timetableTableView.reloadData()
                }
            }
        }
        navigationController?.pushViewController(timetableEditVC, animated: true)
    }
    
    private func greateTimetable() {
        if let item = TimetableModel.init(day: .monday, timeInterval: TimeInterval(begin: Time(hours: "19", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .ut1, trainer: "Ильин Антон Андреевич") {
            timetableList.append(item)
        }
        
        if let item = TimetableModel.init(day: .tuesday, timeInterval: TimeInterval(begin: Time(hours: "19", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .ut2, trainer: "Ильин Антон Андреевич") {
            timetableList.append(item)
        }
        
        if let item = TimetableModel.init(day: .wednesday, timeInterval: TimeInterval(begin: Time(hours: "15", minutes: "00"), end: Time(hours: "20", minutes: "20")), groupName: .ut3, trainer: "Иванов Петр Сергеевич") {
            timetableList.append(item)
        }

        if let item = TimetableModel.init(day: .thursday, timeInterval: TimeInterval(begin: Time(hours: "19", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .np1, trainer: "Ильин Антон Андреевич") {
            timetableList.append(item)
        }
        
        if let item = TimetableModel.init(day: .friday, timeInterval: TimeInterval(begin: Time(hours: "19", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .np2, trainer: "Иванов Петр Сергеевич") {
            timetableList.append(item)
        }
        
        if let item = TimetableModel.init(day: .saturday, timeInterval: TimeInterval(begin: Time(hours: "16", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .np2, trainer: "Иванов Петр Сергеевич") {
            timetableList.append(item)
        }
        
        if let item = TimetableModel.init(day: .sunday, timeInterval: TimeInterval(begin: Time(hours: "19", minutes: "20"), end: Time(hours: "20", minutes: "20")), groupName: .np3, trainer: "Ильин Антон Андреевич") {
            timetableList.append(item)
        }
    }
    
    private func setupTableView() {
        timetableTableView.delegate = self
        timetableTableView.dataSource = self
        timetableTableView.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.reuseId)
        timetableTableView.register(UINib(nibName: TimetableCell.reuseId, bundle: nil), forCellReuseIdentifier: TimetableCell.reuseId)
        timetableTableView.estimatedRowHeight = UITableView.automaticDimension
        timetableTableView.rowHeight = UITableView.automaticDimension
    }
}

extension TimetableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimetableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TimetableCell.reuseId, for: indexPath) as? TimetableCell else {
            return UITableViewCell()
        }
        cell.setup(timetable: filteredTimetableList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let timetableEditVC = UIStoryboard.timetableEdit.instantiateViewController(withIdentifier: "\(TimetableEditViewController.self)") as? TimetableEditViewController, timetableList.count >= indexPath.row else { return }
        timetableEditVC.timetable = filteredTimetableList[indexPath.row]
        timetableEditVC.mode = .edit
        timetableEditVC.completionHandler = { [weak self] timetable in
            if let model = timetable {
                self?.filteredTimetableList[indexPath.row] = model
                if let replaceIndex = self?.timetableList.firstIndex(where: { model.id == $0.id }) {
                    self?.timetableList[replaceIndex] = model
                }
                DispatchQueue.main.async{
                    self?.timetableTableView.reloadData()
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(timetableEditVC, animated: true)
    }
}

extension TimetableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredTimetableList = []
        if searchText.isEmpty {
            filteredTimetableList = timetableList
        }
        for item in timetableList {
            if item.day.rawValue.contains(searchText.lowercased()) {
                filteredTimetableList.append(item)
            }
            
            if item.groupName.rawValue.contains(searchText.lowercased()) {
                filteredTimetableList.append(item)
            }
            
            if item.trainer.lowercased().contains(searchText.lowercased()) {
                filteredTimetableList.append(item)
            }
        }
        self.timetableTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
