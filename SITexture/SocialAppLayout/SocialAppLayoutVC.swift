//
//  SocialAppLayoutVC.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/11.
//

import UIKit

class SocialAppLayoutVC: ASDKViewController<ASTableNode> {

    var tableNode: ASTableNode
    var socialAppDataSource: [SocialModel] = []
    
    override init() {
        tableNode = ASTableNode.init(style: UITableView.Style.plain)
        super.init(node: tableNode)
        
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.title = "TimeLine"
        
        self.createSocialAppDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.tableNode.view.separatorStyle = .none
        
        self.tableNode.reloadData()
    }
    
    
    func createSocialAppDataSource() {
        
        for index in 0..<20 {
            let model = SocialModel.init(index: index)
            self.socialAppDataSource.append(model)
        }
        
    }

    
}

extension SocialAppLayoutVC: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return self.socialAppDataSource.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cellNode = SocialNode.init(model: self.socialAppDataSource[indexPath.item])
        return cellNode
    }
    
}

extension SocialAppLayoutVC: ASTableDelegate {
    
}


let names = ["Jack Guy", "Alex Long Name", "Huy Nguyen", "Bla conne"]
let userNames = ["ssdfasd", "343dsrew", "ssssfdwehhh", "sdfghfds"]
let photos = ["https://avatars2.githubusercontent.com/u/587874?v=3&s=96", "https://avatars1.githubusercontent.com/u/8086633?v=3&s=96", "https://avatars0.githubusercontent.com/u/724423?v=3&s=96",
"https://avatars1.githubusercontent.com/u/565251?v=3&s=96"]
let posts = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. https://github.com/facebook/AsyncDisplayKit Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."]

let times = ["yesterday",
             "3:02",
             "4:19",
             "20:00"]

let medias = ["",
              "http://www.ngmag.ru/upload/iblock/f93/f9390efc34151456598077c1ba44a94d.jpg",
              "",
              ""]

class SocialModel: NSObject {
    
    var name = ""
    var userName = ""
    var photo = ""
    var post = ""
    var time = ""
    var media = ""
    var via = 0
    var likes = Int.random(in: 1..<100)
    var comments = Int.random(in: 1..<100)
    
    init(index: Int) {
        self.name = names[index % 4]
        self.userName = userNames[index % 4]
        self.photo = photos[index % 4]
        self.post = posts[index % 4]
        self.time = times[index % 4]
        self.media = medias[index % 4]
        self.via = Int.random(in: 0..<3)
    }
}

