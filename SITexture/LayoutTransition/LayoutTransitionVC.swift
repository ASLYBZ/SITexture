//
//  LayoutTransitionVC.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/14.
//

import UIKit

class LayoutTransitionVC: BaseVC {

    var transitionNode = TransitionNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubnode(transitionNode)
        transitionNode.backgroundColor = .gray
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = self.transitionNode.layoutThatFits(ASSizeRangeMake(CGSizeZero, self.view.frame.size)).size
        self.transitionNode.frame = CGRect.init(x: 0, y: 100, width: size.width, height: size.height)
    }

}
