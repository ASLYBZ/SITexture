//
//  DynamicFlexboxNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/4/26.
//

import UIKit

class DynamicFlexboxNode: ASDisplayNode {

    var yelllowNode = ASDisplayNode()
    
    var textNodeOne = ASTextNode()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        
        textNodeOne = ASTextNode()
        textNodeOne.attributedText = NSAttributedString.init("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled")
        textNodeOne.backgroundColor = .yellow
    }
    
    override func layoutDidFinish() {
        super.layoutDidFinish()
        
        
        self.view.layer.cornerRadius = self.view.bounds.size.height * 0.5
        self.view.layer.masksToBounds = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        
        let stacklayout = ASStackLayoutSpec.init()
        yelllowNode.style.width = ASDimensionMake(100)
        yelllowNode.style.height = ASDimensionMake(100)
        yelllowNode.backgroundColor = .yellow
        
//        stacklayout.children = [yelllowNode]
        
//        let relativeLayout = ASRelativeLayoutSpec(horizontalPosition: .center, verticalPosition: .center, sizingOption: [], child: yelllowNode)
//        relativeLayout.style.width = ASDimensionMakeWithFraction(1)
//        relativeLayout.style.height = ASDimensionMakeWithFraction(1)
        
//        let stacklayout = ASStackLayoutSpec.init()
//        stacklayout.style.width = ASDimensionMake(100)
//        stacklayout.style.height = ASDimensionMake(100)
//        stacklayout.children = [yelllowNode]
//
        
        let nextTextNode = self.textNodeOne
        nextTextNode.style.flexGrow = 1.0
        nextTextNode.style.flexShrink = 1.0
        let horizontalStackLayout = ASStackLayoutSpec.horizontal()
        horizontalStackLayout.children = [yelllowNode]
        
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10), child: horizontalStackLayout)
    }
    
    
}
