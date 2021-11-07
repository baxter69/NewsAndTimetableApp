//
//  UIStoryboard+.swift
//  NewsApp
//
//  Created by user on 24.10.2021.
//

import Foundation
import UIKit

extension UIStoryboard {
    @nonobjc class var login: UIStoryboard {
        return UIStoryboard(name: Storyboard.login, bundle: nil)
    }
    @nonobjc class var newsItem: UIStoryboard {
        return UIStoryboard(name: Storyboard.newsItem, bundle: nil)
    }
    @nonobjc class var timetableItem: UIStoryboard {
        return UIStoryboard(name: Storyboard.timetableItem, bundle: nil)
    }
    @nonobjc class var newsPage: UIStoryboard {
        return UIStoryboard(name: Storyboard.newsPage, bundle: nil)
    }
    @nonobjc class var timetableEdit: UIStoryboard {
        return UIStoryboard(name: Storyboard.timetableEdit, bundle: nil)
    }
}
