//
//  SupplementaryNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/7.
//

import Foundation

class SupplementaryNode: ASCellNode {
    
    let kInsets = 15.0

    
    var textNode: ASTextNode
    
    let textAttributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                                                          NSAttributedString.Key.foregroundColor: UIColor.white]
        
    
    
    override init() {
        
        self.textNode = ASTextNode.init()
        
        super.init()
        
    }

    func set(text: String) -> Self {
        textNode.attributedText = NSAttributedString.init(string: text, attributes: self.textAttributes)

        addSubnode(textNode)
        return self
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let center = ASCenterLayoutSpec.init()
        center.centeringOptions = ASCenterLayoutSpecCenteringOptions.XY
        center.child = self.textNode
        let insets = UIEdgeInsets(top: kInsets, left: kInsets, bottom: kInsets, right: kInsets)
        
        return ASInsetLayoutSpec.init(insets: insets, child: center)
    }
    
}
