//
//  NewsItemViewController.swift
//  NewsApp
//
//  Created by user on 23.10.2021.
//

import Foundation
import UIKit

class NewsItemViewController: UIViewController {
    
    @IBOutlet private var newsTableView: UITableView!
    
    var news: [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        greateNews()
        setupNewsTableView()
    }
    
    private func setupNewsTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsItemCell.self, forCellReuseIdentifier: NewsItemCell.reuseId)
        newsTableView.register(UINib(nibName: NewsItemCell.reuseId, bundle: nil), forCellReuseIdentifier: NewsItemCell.reuseId)
        newsTableView.estimatedRowHeight = UITableView.automaticDimension
        newsTableView.rowHeight = UITableView.automaticDimension   
    }
    
    private func greateNews() {
        let calendar = Calendar.current
        news.append(NewsModel(imageName: "fencing1", heading: "Российская саблистка Егорян объявила о возобновлении карьеры", short: "Двукратная олимпийская чемпионка по фехтованию Яна Егорян сообщила о возобновлении карьеры.", body: "Двукратная олимпийская чемпионка по фехтованию Яна Егорян сообщила о возобновлении карьеры. «Решение принято, я возобновляю карьеру, хочу вернуться в большой спорт и уже приступила к тренировкам. К такому решению меня побудило отличное выступление нашей сборной в Токио, а также поддержка моего тренера Дмитрия Глотова, который снова готов со мной пройти этот путь. Надеюсь, что на Олимпиаде в Париже мне удастся как минимум испытать такие же эмоции, как на Играх-2016», — приводит слова Егорян ТАСС. 27-летняя россиянка является олимпийской чемпионкой Игр-2016 в личном и командном первенствах. Также в активе Егорян две золотые, две серебряные и две бронзовые медали чемпионатов мира. Двукратная олимпийская чемпионка по фехтованию Яна Егорян сообщила о возобновлении карьеры. Двукратная олимпийская чемпионка по фехтованию Яна Егорян сообщила о возобновлении карьеры. «Решение принято, я возобновляю карьеру, хочу вернуться в большой спорт и уже приступила к тренировкам. К такому решению меня побудило отличное выступление нашей сборной в Токио, а также поддержка моего тренера Дмитрия Глотова, который снова готов со мной пройти этот путь. Надеюсь, что на Олимпиаде в Париже мне удастся как минимум испытать такие же эмоции, как на Играх-2016», — приводит слова Егорян ТАСС. 27-летняя россиянка является олимпийской чемпионкой Игр-2016 в личном и командном первенствах. Также в активе Егорян две золотые, две серебряные и две бронзовые медали чемпионатов мира.", date: calendar.date(from: DateComponents(calendar: Calendar.current, year: 2021, month: 10, day: 1)) ?? Date()))
        
        news.append(NewsModel(imageName: "fencing1", heading: "Олимпийская чемпионка Великая нанесла торжественный первый удар перед дерби ЦСКА — «Спартак»", short: "Двукратная олимпийская чемпионка по фехтованию Софья Великая нанесла торжественный первый удар перед началом матча 8-го тура Тинькофф РПЛ ЦСКА — «Спартак».", body: "Двукратная олимпийская чемпионка по фехтованию Софья Великая нанесла торжественный первый удар перед началом матча 8-го тура Тинькофф РПЛ ЦСКА — «Спартак». Великая вышла в центральный круг поля стадиона «ВЭБ Арена» и нанесла символический удар по мячу. Софья Великая является воспитанницей школы ЦСКА.", date: calendar.date(from: DateComponents(calendar: Calendar.current, year: 2021, month: 9, day: 20)) ?? Date()))
        
        news.append(NewsModel(imageName: "fencing1", heading: "Мужская сборная России по фехтованию выиграла золото Паралимпиады в Токио", short: "Мужская сборная России по фехтованию на колясках завоевала золото командных соревнований шпажистов на Паралимпиаде в Токио. В финале со счетом 45-39 была побеждена сборная Китая.", body: "Мужская сборная России по фехтованию на колясках завоевала золото командных соревнований шпажистов на Паралимпиаде в Токио. В финале со счетом 45-39 была побеждена сборная Китая. За Россию выступали Максим Шабуров, Александр Кузюков и Артур Юсупов. Всего на счету сборной России в общем медальном зачете Паралимпиады в Токио стало 24 медали: 8 золотых, 6 серебряных и 10 бронзовых наград.", date: calendar.date(from: DateComponents(calendar: Calendar.current, year: 2021, month: 8, day: 27)) ?? Date()))
        
    }
}

extension NewsItemViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsItemCell.reuseId, for: indexPath) as? NewsItemCell else {
            return UITableViewCell()
        }
        cell.setup(news: news[indexPath.row])
//        var content = cell.defaultContentConfiguration()
//        content.image = UIImage(systemName: "star")
//        content.text = "Favorites"
//        content.imageProperties.tintColor = .purple
//        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsVC = UIStoryboard.newsPage.instantiateViewController(withIdentifier: "\(NewsPageViewController.self)") as? NewsPageViewController, news.count >= indexPath.row else { return }
        newsVC.news = news[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(newsVC, animated: true)
    }
}
