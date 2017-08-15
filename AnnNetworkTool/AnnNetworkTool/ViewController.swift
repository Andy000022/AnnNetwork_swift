//
//  ViewController.swift
//  AnnNetworkTool
//
//  Created by iSolar on 2017/8/14.
//  Copyright © 2017年 nothing. All rights reserved.
//

import UIKit
import MJExtension
import ColorExtension

class ViewController: UIViewController {

    let kWidth = UIScreen.main.bounds.width
    let kHeight = UIScreen.main.bounds.height
    
    var numL = UILabel()
    var data = [ListModel]()
    
    fileprivate lazy var table = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "request"
        
        table = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: kHeight), style: .plain)
        self.view.addSubview(table)
        table.backgroundColor = UIColor.init(hexString: "e2e3e0")
        table.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: kWidth, height: 130))
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.allowsSelection = false
        table.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        let btn = UIButton.init(frame: CGRect.init(x: 30, y: 30, width: (kWidth - 90)/2, height: 35))
        table.tableHeaderView?.addSubview(btn)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 10
        btn.tag = 10
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.setTitle("request", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(self.requestData(sender:)), for: .touchUpInside)
    
        let clearBtn = UIButton.init(frame: CGRect.init(x: 30 * 2 + (kWidth - 90)/2, y: 30, width: (kWidth - 90)/2, height: 35))
        clearBtn.layer.cornerRadius = 11
        clearBtn.backgroundColor = UIColor.white
        table.tableHeaderView?.addSubview(clearBtn)
        clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        clearBtn.setTitle("clear", for: .normal)
        clearBtn.setTitleColor(UIColor.green, for: .normal)
        clearBtn.tag = 11
        clearBtn.addTarget(self, action: #selector(self.requestData(sender:)), for: .touchUpInside)
        
        numL = UILabel.init(frame: CGRect.init(x: 20, y: 90, width: kWidth - 40, height: 20))
        numL.textAlignment = .center
        numL.textColor = UIColor.brown
        table.tableHeaderView?.addSubview(numL)
        
        
    }


    func requestData( sender : UIButton) {
    
        print("------\(sender.tag)---------")
        
        switch sender.tag {
        case 10:
            // https://news-at.zhihu.com/api/4/news/before/20131119
        
            AnnNetwork.networkTool.request(requestType: .GET, url: "https://news-at.zhihu.com/api/4/news/before/20131119", parameters: nil, succeed: { (obj) in
                
                print("\n\n\(obj!)\n\n")
                
                let dataArr : [[String:AnyObject]] = obj!["stories"] as! [[String : AnyObject]]
                
                for dic in dataArr {
                
                    let model = ListModel()
                    model.mj_setKeyValues(dic)
                    self.data.append(model)
                    
                }
                
                self.numL.text = "\(self.data.count)"
                
                self.table.reloadData()
                
            }, failure: { (error) in
                print(error!)
            })
            
            break
        case 11:
            
            self.data.removeAll()
            self.numL.text = "\(self.data.count)"
            self.table.reloadData()
            
            break
        default:
            break
        }
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1.创建cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        cell.model = self.data[indexPath.row]
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.white
    }
    
}
