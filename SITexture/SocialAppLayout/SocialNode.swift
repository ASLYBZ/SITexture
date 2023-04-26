//
//  SocialNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2023/1/11.
//

import UIKit

class SocialNode: ASCellNode {
    
    var model: SocialModel?
    
    var divider = ASDisplayNode.init()
    var nameNode = ASTextNode.init()
    var usernameNode = ASTextNode.init()
    var timeNode = ASTextNode.init()
    var postNode = ASTextNode.init()
    var mediaNode = ASNetworkImageNode.init()
    var avatarNode = ASNetworkImageNode.init()
    var viaNode = ASImageNode.init()
    var likeNode: LikesNode?
    var commontsNode: CommentsNode?
    var optionsNode = ASImageNode.init()
    
    init(model: SocialModel?) {
        
        super.init()
        self.model = model
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
        guard let model = model else {
            return
        }
        
        nameNode.attributedText = NSAttributedString.init(string: model.name, attributes: TextStyles.nameStyle())
        nameNode.maximumNumberOfLines = 1
        self.addSubnode(nameNode)
        
        
        usernameNode.attributedText = NSAttributedString.init(string: model.userName, attributes: TextStyles.usernameStyle())
        usernameNode.style.flexShrink = 1.0
        usernameNode.truncationMode = NSLineBreakMode.byTruncatingTail
        usernameNode.maximumNumberOfLines = 1
        self.addSubnode(usernameNode)
        
        timeNode.attributedText = NSAttributedString.init(string: model.time, attributes: TextStyles.timeStyle())
        self.addSubnode(timeNode)
        
        
        if !model.post.isEmpty {
            let attrString = NSMutableAttributedString.init(string: model.post, attributes: TextStyles.postStyle())
            
            
            if let urlDetector = try? NSDataDetector.init(types: NSTextCheckingResult.CheckingType.link.rawValue) {
                urlDetector.enumerateMatches(in: attrString.string, range: NSRange.init(location: 0, length: attrString.string.count)) { result, flags, stop in
                    if result?.resultType == NSTextCheckingResult.CheckingType.link, let range = result?.range {
                        var linkAttributes = TextStyles.postLinkStyle()
                        linkAttributes[NSAttributedString.Key.link] = URL(string: result?.url?.absoluteString ?? "")
                        attrString.addAttributes(linkAttributes, range: range)
                    }
                }
            }
            
            postNode.delegate = self
            postNode.isUserInteractionEnabled = true
            postNode.linkAttributeNames = [NSAttributedString.Key.link.rawValue]
            postNode.attributedText = attrString
            postNode.passthroughNonlinkTouches = true
        }
        
        self.addSubnode(postNode)
        
        if !model.media.isEmpty {
            mediaNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
            mediaNode.cornerRadius = 4.0
            mediaNode.url = URL(string: model.media)!
            mediaNode.delegate = self
            mediaNode.imageModificationBlock = { (image, traitCollection) -> UIImage in
                
                let rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
                UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
                UIBezierPath(roundedRect: rect, cornerRadius: 8.0).addClip()
                image.draw(in: rect)
                let modifiedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
                UIGraphicsEndImageContext()
                return modifiedImage
            }
            
            self.addSubnode(mediaNode)
        }
        
        
        avatarNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor()
        avatarNode.style.width = ASDimensionMakeWithPoints(44)
        avatarNode.style.height = ASDimensionMakeWithPoints(44)
        avatarNode.cornerRadius = 22.0
        avatarNode.url = URL(string: model.photo)
        avatarNode.imageModificationBlock = { (image, traitCollection) -> UIImage in
            let rect = CGRect.init(x: 0, y: 0, width: image.size.width, height: image.size.height)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: 44.0).addClip()
            image.draw(in: rect)
            let modifiedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
            UIGraphicsEndImageContext()
            return modifiedImage
        }
        
        self.addSubnode(avatarNode)
        self.updateDividerColor()
        self.addSubnode(divider)
        
        
        if model.via != 0 {
            viaNode.image = UIImage(named: model.via == 1 ? "icon_ios.png" : "icon_android.png")
            self.addSubnode(viaNode)
        }
        
        likeNode = LikesNode.init(likesCount: model.likes)
        self.addSubnode(likeNode!)
        
        commontsNode = CommentsNode.init(commentsCount: model.comments)
        self.addSubnode(commontsNode!)
        
        
        
    }
    
    
    func updateDividerColor() {
        divider.backgroundColor = UIColor.lightGray
    }
}

extension SocialNode: ASTextNodeDelegate {
    
    func textNode(_ textNode: ASTextNode!, shouldHighlightLinkAttribute attribute: String!, value: Any!, at point: CGPoint) -> Bool {
        return true
    }
    
    func textNode(_ textNode: ASTextNode!, tappedLinkAttribute attribute: String!, value: Any!, at point: CGPoint, textRange: NSRange) {
        
        guard let url = value as? URL else {
            return
        }
        
        UIApplication.shared.openURL(url)
    }
}

extension SocialNode: ASNetworkImageNodeDelegate {
    func imageNode(_ imageNode: ASNetworkImageNode, didLoad image: UIImage) {
        self.setNeedsLayout()
    }
}


class TextStyles: NSObject {
    
    static func nameStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.boldSystemFont(ofSize: 15), .foregroundColor: UIColor.black]
    }
    
    static func usernameStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.lightGray]
    }
    
    static func timeStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.gray]
    }
    
    static func postStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.black]
    }
    
    static func postLinkStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.init(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0), .underlineStyle: NSUnderlineStyle.single.rawValue]
    }
    
    static func cellControlStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.lightGray]
    }

    static func cellControlColoredStyle() -> [NSAttributedString.Key: Any] {
        return [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.init(red: 59.0/255.0, green: 89.0/255.0, blue: 152.0/255.0, alpha: 1.0)]
    }
}
