//
//  NewsItemCell.swift
//  NewsApp
//
//  Created by user on 23.10.2021.
//

import Foundation
import UIKit

class NewsItemCell: UITableViewCell {
    static let reuseId = "NewsItemCell"
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var headingNewsLabel: UILabel!
    @IBOutlet weak var shortNewsLabel: UILabel!
    @IBOutlet weak var dateNewsLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
    
    func setup(news: NewsModel) {
        
        headingNewsLabel.text = news.heading
        
        if !news.imageName.isEmpty {
            newsImageView.image = UIImage(named: news.imageName)
        }
        
        shortNewsLabel.text = news.short
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "ru")
        
        
        dateNewsLabel.text = dateFormatter.string(from: news.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        self.contentsView.backgroundColor = selected ? .aliceBlue : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.contentsView.backgroundColor = highlighted ? .aliceBlue : .clear
    }
}
