//
//  TransitionNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/14.
//

import UIKit

class TransitionNode: ASDisplayNode {
    
    static let defaultLayoutTransitionDuration = 1.0
    var enabled = false
    var buttonNode = ASButtonNode()
    var textNodeOne = ASTextNode()
    var textNodeTwo = ASTextNode()
    
    override init() {
        super.init()
        self.automaticallyManagesSubnodes = true
        
        textNodeOne = ASTextNode()
        textNodeOne.attributedText = NSAttributedString.init("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled")
        
        
        textNodeTwo = ASTextNode()
        textNodeTwo.attributedText = NSAttributedString.init("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.")
        
        
        let buttonTitle = "Start Layout Transition"
        let buttonFont = UIFont.boldSystemFont(ofSize: 16)
        let buttonColor = UIColor.blue
        
        buttonNode.setTitle(buttonTitle, with: buttonFont, with: buttonColor, for: .normal)
        buttonNode.setTitle(buttonTitle, with: buttonFont, with: buttonColor.withAlphaComponent(0.5), for: UIControl.State.highlighted)
        
        
        // Some debug colors
        textNodeOne.backgroundColor = UIColor.orange
        textNodeTwo.backgroundColor = UIColor.green

    }
    
    override func didLoad() {
        super.didLoad()
        
        buttonNode.addTarget(self, action: #selector(buttonPressed), forControlEvents: ASControlNodeEvent.touchUpInside)
    }

    
    @objc(buttonPressed:)
    func buttonPressed(_ sender: Any) {
        print("XXXXXXXXX - buttonPressed")
        
        self.enabled = !self.enabled
        self.transitionLayout(withAnimation: true, shouldMeasureAsync: false)
    }
    
    
    // layout
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let nextTextNode = self.enabled ? self.textNodeTwo : self.textNodeOne
        nextTextNode.style.flexGrow = 1.0
        nextTextNode.style.flexShrink = 1.0
        let horizontalStackLayout = ASStackLayoutSpec.horizontal()
        horizontalStackLayout.children = [nextTextNode]
        
        self.buttonNode.style.alignSelf = ASStackLayoutAlignSelf.center
        
        let verticalStackLayout = ASStackLayoutSpec.vertical()
        verticalStackLayout.spacing = 10.0
        verticalStackLayout.children = [horizontalStackLayout, self.buttonNode]
        
        return ASInsetLayoutSpec.init(insets: UIEdgeInsets.init(top: 15, left: 15, bottom: 15, right: 15), child: verticalStackLayout)
    }
    
    // 动画
    override func animateLayoutTransition(_ context: ASContextTransitioning) {
        
        let fromNode = context.removedSubnodes()[0]
        let toNode = context.insertedSubnodes()[0]
        
        var buttonNode: ASButtonNode? = nil
        
        for node in context.subnodes(forKey: ASTransitionContextToLayoutKey) {
            if node.isKind(of: ASButtonNode.self) {
                buttonNode = (node as! ASButtonNode)
                break
            }
        }
        
        var toNodeFrame = context.finalFrame(for: toNode)
        toNodeFrame.origin.x += (self.enabled ? toNodeFrame.size.width : -toNodeFrame.size.width)
        toNode.frame = toNodeFrame
        toNode.alpha = 0.0
        
        var fromNodeFrame = fromNode.frame
        fromNodeFrame.origin.x += (self.enabled ? -fromNodeFrame.size.width : fromNodeFrame.size.width)
            
        UIView.animate(withDuration: self.defaultLayoutTransitionDuration) {
         
            toNode.frame = context.finalFrame(for: toNode)
            toNode.alpha = 1.0
            
            fromNode.frame = fromNodeFrame
            fromNode.alpha = 0.0
            
            let fromSize = context.layout(forKey: ASTransitionContextFromLayoutKey)?.size ?? .zero
            let toSize = context.layout(forKey: ASTransitionContextToLayoutKey)?.size ?? .zero
            let isResized = CGSizeEqualToSize(fromSize, toSize) == false
            if isResized {
                let position = self.frame.origin
                self.frame = CGRect.init(x: position.x, y: position.y, width: toSize.width, height: toSize.height)
            }
            buttonNode?.frame = context.finalFrame(for: buttonNode!)
        } completion: { finished in
            context.completeTransition(finished)
        }

    }
}
