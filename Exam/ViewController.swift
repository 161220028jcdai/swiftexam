//
//  ViewController.swift
//  Exam
//
//  Created by Apple on 2019/12/23.
//  Copyright © 2019 Exam. All rights reserved.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var loading: UIActivityIndicatorView = {
        let object = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        object.hidesWhenStopped = true
        return object
    }()
    
    let new_url = "https://hr.nju.edu.cn"
    
    var dataSource: [[News]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loading)
        tableView.tableFooterView = UIView()
        navigationItem.title = "南大人事"
        loading.startAnimating()
        loading.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
        // 加载网页数据
        let task = URLSession.shared.dataTask(with: URL(string: new_url)!) {[weak self] (data, response, error) in
            if let value = data, let xmlString = String(data: value, encoding: String.Encoding.utf8), error == nil {
                self?.decodeXMl(xmlString: xmlString)
            } else {
                DispatchQueue.main.async {
                    self?.loading.stopAnimating()
                }
                debugPrint("加载网页数据失败: %@", error.debugDescription);
            }
        }
        task.resume()
    }
    
    /// 解析XML数据
    ///
    /// - Parameter xml: xml数据
    fileprivate func decodeXMl(xmlString: String) {
        dataSource.append(parseXML(xmlString: xmlString, element: "wp_news_w5"))
        dataSource.append(parseXML(xmlString: xmlString, element: "wp_news_w4"))
        dataSource.append(parseXML(xmlString: xmlString, element: "wp_news_w6"))
        dataSource.append(parseXML(xmlString: xmlString, element: "wp_news_w7"))
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    fileprivate func parseXML(xmlString: String, element: String) -> [News] {
        var result = [News]()
        do {
            let doc: Document = try SwiftSoup.parse(xmlString)
            guard let list = try doc.getElementById(element)?.getElementsByTag("li") else { return result }
            
            for elem in list {
                let title = try elem.getElementsByTag("a")[0].attr("title")
                let href = try elem.getElementsByTag("a")[0].attr("href")
                let date = try elem.getElementsByClass("news_meta")[0].text()
                var countString = try elem.getElementsByClass("news_meta1")[0].text()
                countString.removeFirst()
                countString.removeLast()
                let count = Int(countString) ?? 0
                let item = News(title: title, count: count, url: "\(new_url)\(href)", date: date)
                result.append(item)
            }
        }catch {
            print(error)
        }
        return result
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let news = dataSource[indexPath.section][indexPath.row]
        cell.news = news
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // 跳转到WebViewController
        performSegue(withIdentifier:"showNews", sender: dataSource[indexPath.section][indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "人事通知"
        } else if section == 1 {
            return "人事新闻"
        } else if section == 2 {
            return "公示公告"
        } else if section == 3 {
            return "招聘信息"
        }
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNews" {
            guard let news = sender as? News, let controller = segue.destination as? WebViewController else {
                return
            }
            controller.news = news
        }
    }
}

