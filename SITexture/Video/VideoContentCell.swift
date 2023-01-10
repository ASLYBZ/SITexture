//
//  VideoContentCell.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/10.
//

import UIKit

class VideoContentCell: ASCellNode {

    var videoModel: VideoModel
    var titleNode = ASTextNode()
    var avatarNode = ASNetworkImageNode()
    var likeButtonNode = ASControlNode()
    var muteButtonNode = ASButtonNode()
    var videoPlayerNode: ASVideoPlayerNode
    
    init(video: VideoModel) {
        
        videoModel = video
        videoPlayerNode = ASVideoPlayerNode.init(url: videoModel.url)

        super.init()
        
        titleNode.attributedText = NSAttributedString.init(string: videoModel.title, attributes: self.titleNodeStringOptions())
        titleNode.style.flexGrow = 1.0
        
        self.addSubnode(titleNode)
        
        avatarNode.url = videoModel.avatarUrl
        
        avatarNode.imageModificationBlock = { (image, traitCollection) -> (UIImage) in
            let profileImageSize = CGSizeMake(30, 30)
            return image.makeCircularImage(size: profileImageSize)
        }
        
        self.addSubnode(avatarNode)
        
        likeButtonNode.backgroundColor = .red
        self.addSubnode(likeButtonNode)
        
        muteButtonNode.style.width = ASDimensionMake(16.0)
        muteButtonNode.style.height = ASDimensionMake(22.0)
        muteButtonNode.addTarget(self, action: #selector(didTapMuteButton), forControlEvents: .touchUpInside)
    
        videoPlayerNode.delegate = self
        videoPlayerNode.backgroundColor = .black
        self.addSubnode(videoPlayerNode)
        
        self.setMuteButtonIcon()
    }
    
    
    func titleNodeStringOptions() -> [NSAttributedString.Key: Any]? {
     
        return [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    @objc func didTapMuteButton() {
        videoPlayerNode.muted = videoPlayerNode.muted
        self.setMuteButtonIcon()
    }
    
    func setMuteButtonIcon() {
        if videoPlayerNode.muted {
            muteButtonNode.setImage(UIImage(named: "ico-mute"), for: .normal)
        } else {
            muteButtonNode.setImage(UIImage(named: "ico-unmute"), for: .normal)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let fullWidth = UIScreen.main.bounds.size.width
        
        videoPlayerNode.style.width = ASDimensionMake(fullWidth)
        videoPlayerNode.style.height = ASDimensionMake(fullWidth * 9 / 16)
        
        avatarNode.style.width = ASDimensionMake(30)
        avatarNode.style.height = ASDimensionMake(30)
        
        likeButtonNode.style.width = ASDimensionMake(50.0)
        likeButtonNode.style.height = ASDimensionMake(26.0)

        let headerStack  = ASStackLayoutSpec.horizontal()
        headerStack.spacing = 10
        headerStack.alignItems = ASStackLayoutAlignItems.center
        headerStack.children = [avatarNode, titleNode]

        let headerInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        
        let headerInset = ASInsetLayoutSpec.init(insets: headerInsets, child: headerStack)

        let bottomControlsStack = ASStackLayoutSpec.horizontal()
        bottomControlsStack.spacing = 10
        bottomControlsStack.alignItems = ASStackLayoutAlignItems.center
        bottomControlsStack.children = [likeButtonNode]

        let bottomControlsInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)

        let bottomControlsInset = ASInsetLayoutSpec.init(insets: bottomControlsInsets, child: bottomControlsStack)

        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.alignItems = ASStackLayoutAlignItems.stretch
        verticalStack.children = [headerInset, videoPlayerNode, bottomControlsInset]
        return verticalStack
    }
    
    func controlsForControlBar(_ availableControls: [AnyHashable: Any]) -> [ASLayoutElement] {
        var controls = [ASLayoutElement]()

        if let playbackButton = availableControls[ASVideoPlayerNodeControlType.playbackButton.rawValue] as? ASLayoutElement {
            controls.append(playbackButton)
        }

        if let elapsedText = availableControls[ASVideoPlayerNodeControlType.elapsedText.rawValue] as? ASLayoutElement {
            controls.append(elapsedText)
        }

        if let scrubber = availableControls[ASVideoPlayerNodeControlType.scrubber.rawValue] as? ASLayoutElement {
            controls.append(scrubber)
        }

        if let durationText = availableControls[ASVideoPlayerNodeControlType.durationText.rawValue] as? ASLayoutElement {
            controls.append(durationText)
        }

        return controls
    }
}

extension VideoContentCell: ASVideoPlayerNodeDelegate {
    
    func didTap(_ videoPlayer: ASVideoPlayerNode) {
        if videoPlayerNode.playerState == ASVideoNodePlayerState.playing {
            videoPlayerNode.controlsDisabled = !videoPlayerNode.controlsDisabled
            videoPlayerNode.pause()
        } else {
            videoPlayerNode.play()
        }
    }
    
    func videoPlayerNodeCustomControls(_ videoPlayer: ASVideoPlayerNode) -> [AnyHashable : Any] {
        return ["muteControl": muteButtonNode]
    }
    
    
    func videoPlayerNodeLayoutSpec(_ videoPlayer: ASVideoPlayerNode, forControls controls: [AnyHashable : Any], forMaximumSize maxSize: CGSize) -> ASLayoutSpec {
        
        let spacer = ASLayoutSpec.init()
        spacer.style.flexGrow = 1.0
        
        let insets = UIEdgeInsets.init(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        
        if var scrubber = controls[ASVideoPlayerNodeControlType.scrubber.rawValue] as? ASDisplayNode {
            scrubber.style.height = ASDimensionMake(44)
            scrubber.style.minWidth = ASDimensionMake(10)
            scrubber.style.maxWidth = ASDimensionMake(maxSize.width)
            scrubber.style.flexGrow = 1.0
        }
        
        let controlBarControls = self.controlsForControlBar(controls)
        var topBarControls = [ASLayoutElement]()
        
        //Our custom control
        if let muteControl = controls["muteControl"] as? ASLayoutElement {
            topBarControls.append(muteControl)
        }
        
        let topBarSpec = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10.0, justifyContent: .start, alignItems: .center,
                                                children: topBarControls)
        
        let topBarInsetSpec = ASInsetLayoutSpec.init(insets: insets, child: topBarSpec)
        
        let controlbarSpec = ASStackLayoutSpec.init(direction: .horizontal, spacing: 10.0, justifyContent: .start, alignItems: .center, children: controlBarControls)
        controlbarSpec.style.alignSelf = .stretch

        let controlbarInsetSpec = ASInsetLayoutSpec(insets: insets, child: controlbarSpec)
        controlbarInsetSpec.style.alignSelf = .stretch
        
        let mainVerticalStack = ASStackLayoutSpec.init(direction: .vertical,
                                                       spacing: 0,
                                                       justifyContent: .start,
                                                       alignItems: .start,
                                                       children: [topBarInsetSpec, spacer, controlbarInsetSpec])
        
        return mainVerticalStack
    }
    
}
