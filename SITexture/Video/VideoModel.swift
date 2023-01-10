//
//  VideoModel.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/10.
//

import UIKit

class VideoModel: NSObject {
    private(set) var title = "Demo title"
    private(set) var url: URL
    private(set) var userName = "Random User"
    private(set) var avatarUrl: URL
    
    override init() {
        let videoUrlString = "https://www.w3schools.com/html/mov_bbb.mp4"
        let avatarUrlString = "https://api.adorable.io/avatars/50/\(ProcessInfo.processInfo.globallyUniqueString)"
        url = URL(string: videoUrlString)!
        print("avatar url = \(avatarUrlString)")
        avatarUrl = URL(string: avatarUrlString)!
        
        super.init()
        
    }
}
