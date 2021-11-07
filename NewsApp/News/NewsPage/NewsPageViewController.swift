//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by user on 24.10.2021.
//

import Foundation
import UIKit

class NewsPageViewController: UIViewController {
    @IBOutlet private var headingLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var newsImageView: UIImageView!
    
    public var news: NewsModel? = nil
    
    override func viewDidLoad() {
        if let news = self.news {
            self.navigationItem.title = news.heading
            headingLabel.text = news.heading
            bodyLabel.text = news.body
            newsImageView.image = UIImage(named: news.imageName)
        }
    }
}
