//
//  TimetableCell.swift
//  NewsApp
//
//  Created by user on 26.10.2021.
//

import Foundation
import UIKit

class TimetableCell: UITableViewCell {
    @IBOutlet private var contentsView: UIView!
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var groupLabel: UILabel!
    @IBOutlet private var trainerLabel: UILabel!
//    override var selectionStyle: UITableViewCell.SelectionStyle {
//        let selec: UITableViewCell.SelectionStyle = .blue
//        return selec
//    }()
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let reuseId = "TimetableCell"
    
    func setup(timetable: TimetableModel) {
        dayLabel.text = timetable.day.rawValue.capitalized
        timeLabel.text = timetable.timeInterval.getString()
        groupLabel.text = timetable.groupName.rawValue.capitalizeFirst()
        trainerLabel.text = timetable.trainer
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.contentsView.backgroundColor = selected ? .aliceBlue : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.contentsView.backgroundColor = highlighted ? .aliceBlue : .clear
    }
}
