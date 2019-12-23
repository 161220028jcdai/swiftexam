//
//  ViewController.swift
//  Exam
//
//  Created by Apple on 2019/12/23.
//  Copyright © 2019 Exam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [[News]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        dataSource = [
            [
                News(title: "教育部等七部门印发《关于加强和改进新时代师德师风建设的意见》的通知", count: 418, url: "https://hr.nju.edu.cn/df/a3/c5977a450467/page.htm", date: "2019-12-16"),
                News(title: "外语培训费用报销通知", count: 275, url: "https://hr.nju.edu.cn/c8/51/c5977a444497/page.htm", date: "2019-12-10"),
                News(title: "关于开展2020年度省“青蓝工程”培养对象选拔工作的通知", count: 182, url: "https://hr.nju.edu.cn/e5/48/c5977a451912/page.htm", date: "2019-12-19"),
                News(title: "关于遴选2020年“南京学者”项目留学人选的通知", count: 667, url: "https://hr.nju.edu.cn/bf/e9/c5977a442345/page.htm", date: "2019-11-25")
            ],
            [
                News(title: "西北工业大学党委常委、副校长侯成义一行来我校调研", count: 124, url: "https://hr.nju.edu.cn/ef/ab/c5976a454571/page.htm", date: "2019-12-20"),
                News(title: "人力资源处、党委教师工作部赴上海调研", count: 424, url: "https://hr.nju.edu.cn/c2/2d/c5976a442925/page.htm", date: "2019-11-29"),
                News(title: "南京大学任洪强教授当选中国工程院院士", count: 7343, url: "http://news.nju.edu.cn/show_article_1_54530", date: "2019-11-22"),
                News(title: "我校召开本学期第二次人事秘书工作例会", count: 406, url: "https://hr.nju.edu.cn/bb/dc/c5976a441308/page.htm", date: "2019-11-15"),
                News(title: "我校召开师德师风建设工作培训会议", count:489, url: "https://hr.nju.edu.cn/a6/f7/c5976a435959/page.htm", date: "2019-10-24"),
                News(title: "我校召开2019年下半年人事秘书工作例会", count:654, url: "https://hr.nju.edu.cn/a1/43/c5976a434499/page.htm", date: "2019-10-17"),
                News(title: "我校召开新学期人才人事工作布置会暨“第一资源开发”系列文件、政策解读会", count:6007, url: "http://news.nju.edu.cn/show_article_1_53921", date: "2019-09-28")
            ],
            [
                News(title: "党委教师工作部师德师风监督、举报指南", count: 4762, url: "https://hr.nju.edu.cn/e6/92/c5978a255634/page.htm", date: "2018-04-18"),
                News(title: "关于校内调动人员情况的公示", count: 319, url: "https://hr.nju.edu.cn/e5/22/c5978a451874/page.htm", date: "2019-12-19"),
                News(title: "人力资源处鼓楼校区值班表（2019.8-2020.1）", count: 827, url: "https://hr.nju.edu.cn/11/e3/c5978a397795/page.htm", date: "2019-08-23"),
                News(title: "办理收入、因私出国、同意兼职证明手续（新）", count: 7720, url: "https://hr.nju.edu.cn/30/36/c5978a208950/page.htm", date: "2017-07-04"),
                News(title: "工作证办理及补办流程", count:3184, url: "https://hr.nju.edu.cn/5f/9c/c5978a155548/page.htm", date: "2016-09-06")
            ],
            [News(title: "招聘公告1099（化学化工学院科研助理）", count: 171, url: "https://hr.nju.edu.cn/ef/0a/c5979a454410/page.htm", date: "2019-12-19"),
             News(title: "招聘公告1098（环境学院工勤）", count: 101, url: "https://hr.nju.edu.cn/ef/08/c5979a454408/page.htm", date: "2019-12-19"),
             News(title: "关于公开招聘信息管理学院研究系列人员的启事（20191206）", count: 117, url: "https://hr.nju.edu.cn/ef/07/c5979a454407/page.htm", date: "2019-12-19"),
             News(title: "关于公开招聘大气科学学院研究系列人员的启事（20191205）", count: 104, url: "https://hr.nju.edu.cn/ef/01/c5979a454401/page.htm", date: "2019-12-19"),
             News(title: "招聘公告1097（教育发展基金会项目管理和项目扩展2名）", count:438, url: "https://hr.nju.edu.cn/df/ae/c5979a450478/page.htm", date: "2019-12-16")
            ]
        ]
        navigationItem.title = "南大人事"
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

