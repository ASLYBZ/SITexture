//
//  VideoFeedNodeController.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/10.
//

import UIKit

class VideoFeedNodeController: ASDKViewController<ASTableNode> {

    var tableNode: ASTableNode
    
    var videoFeedData: [VideoModel] = []
    
    override init() {
        let tableNode = ASTableNode(style: .plain)
        self.tableNode = tableNode
        super.init(node: tableNode)

        
        self.tableNode.dataSource = self
        self.generateFeedData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = self.tableNode
        self.tableNode.reloadData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    func generateFeedData() {
        for _ in 0..<30 {
            videoFeedData.append(VideoModel.init())
        }
    }
   

    deinit {
        print("dealloc -- VideoFeedNodeController")
    }
}

extension VideoFeedNodeController: ASTableDelegate {
    
}

extension VideoFeedNodeController: ASTableDataSource {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return videoFeedData.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let videoModel = videoFeedData[indexPath.item]
        let nodeCell = VideoContentCell.init(video: videoModel)
        return nodeCell
    }
}
