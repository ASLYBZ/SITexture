//
//  ASAnimatedImageVC.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/6.
//

import UIKit


/// 动图
class ASAnimatedImageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let imageNode = ASNetworkImageNode()
        imageNode.url = URL.init(string: "https://i.pinimg.com/originals/07/44/38/074438e7c75034df2dcf37ba1057803e.gif")
        imageNode.frame = self.view.bounds
        imageNode.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        imageNode.contentMode = .scaleAspectFit

        self.view.addSubnode(imageNode)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
