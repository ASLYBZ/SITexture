//
//  LikesNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/13.
//

import UIKit

class LikesNode: ASControlNode {

    var likesCount: Int
    var liked = false
    var iconNode = ASImageNode.init()
    var countNode = ASTextNode.init()
    
    init(likesCount: Int) {
        
        self.likesCount = likesCount
        
        super.init()
        
        liked = likesCount > 0 ? self.getYesOrNo() : false
        iconNode.image = UIImage(named: liked ? "icon_liked.png" : "icon_like.png")
        self.addSubnode(iconNode)
        
        if likesCount > 0 {
            let attributes = liked ? TextStyles.cellControlColoredStyle() : TextStyles.cellControlStyle()
            countNode.attributedText = NSAttributedString(string: "\(likesCount)", attributes: attributes)
            
            self.addSubnode(countNode)
            
            self.hitTestSlop = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        }
    }
    
    func getYesOrNo() -> Bool {
        let tmp = Int.random(in: 0..<30) + 1
        return tmp % 5 == 0
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .horizontal, spacing: 6, justifyContent: .start, alignItems: .center, children: [iconNode, countNode])
        
        mainStack.style.minWidth = ASDimensionMake(60)
        mainStack.style.maxHeight = ASDimensionMake(40)
        return mainStack
    }
}
