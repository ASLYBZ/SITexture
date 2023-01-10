//
//  ViewController.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/6.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    let dataSource: [[String: String]] = [
        ["title": "AnimationImage", "VC": "ASAnimatedImageVC"],
        ["title": "ASCollectionViewVC", "VC": "ASCollectionViewVC"],
        ["title": "TTViewController", "VC": "TTViewController"],
        ["title": "LayoutTransitionVC", "VC": "LayoutTransitionVC"],
        ["title": "VideoFeedNodeController", "VC": "VideoFeedNodeController"],
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(tableView)
        self.tableView.frame = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height-64)
        self.tableView.reloadData()
        
        print(LTString().twoSum([3, 2, 4], 5))
        
        
        
        
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.dataSource[indexPath.row]["VC"] else {
            return
        }
        
        switch vc {
        case "ASAnimatedImageVC":
            let vc = ASAnimatedImageVC.init()
            self.navigationController?.pushViewController(vc, animated: true)
        case "ASCollectionViewVC":
            let vc = ASCollectionViewVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case "TTViewController":
            let vc = TTViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case "LayoutTransitionVC":
            let vc = LayoutTransitionVC()
            self.navigationController?.pushViewController(vc, animated: true)
        case "VideoFeedNodeController":
            let vc = VideoFeedNodeController()
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = self.dataSource[indexPath.row]["title"]
        
        return cell
    }
    
    
}

