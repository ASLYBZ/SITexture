//
//  CommentsNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/13.
//

import UIKit

class CommentsNode: ASControlNode {

    var commentsCount: Int = 0
    var iconNode = ASImageNode.init()
    var countNode = ASTextNode.init()
    
    init(commentsCount: Int) {
        super.init()
        
        self.commentsCount = commentsCount
        iconNode.image = UIImage(named: "icon_comment.png")
        self.addSubnode(iconNode)
        
        if commentsCount > 0 {
            countNode.attributedText = NSAttributedString.init(string: "\(commentsCount)", attributes: TextStyles.cellControlStyle())
        }
        
        self.addSubnode(countNode)
        
        self.hitTestSlop = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: -10)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainStack = ASStackLayoutSpec(direction: .horizontal, spacing: 6, justifyContent: .start, alignItems: .center, children: [iconNode, countNode])
        mainStack.style.minWidth = ASDimensionMake(60)
        mainStack.style.maxHeight = ASDimensionMake(40)
        return mainStack
    }
}
