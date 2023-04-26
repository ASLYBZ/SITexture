//
//  DynamicVC.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/4/26.
//

import UIKit
import SnapKit

class DynamicVC: BaseVC {

    var v = UIView()
    var flexboxNode: DynamicFlexboxNode?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        flexboxNode = DynamicFlexboxNode.init {
//
//            self.v.backgroundColor = .red
//            return self.v
//        }
        
        flexboxNode = DynamicFlexboxNode()
        flexboxNode?.backgroundColor = .red
        flexboxNode?.view.tag = 1
        
        let yelllowNode = DynamicFlexboxNode.init()
        yelllowNode.backgroundColor = .yellow
        
        
        self.view.addSubnode(flexboxNode!)
        
//        flexboxNode.frame = CGRect(x: 10, y: 100, width: self.view.bounds.size.width-20, height: 100)
//        let size = flexboxNode.layoutThatFits(ASSizeRange(min: CGSize(width: self.view.bounds.size.width-20, height: 0), max: CGSize(width: self.view.bounds.size.width-20, height: 100))).size
//        flexboxNode.frame = CGRect(x: 10, y: 100, width: size.width, height: size.height)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = self.flexboxNode!.layoutThatFits(ASSizeRangeMake(CGSizeZero, self.view.frame.size)).size
        self.flexboxNode!.frame = CGRect.init(x: 0, y: 100, width: size.width, height: size.height)
    }
}



