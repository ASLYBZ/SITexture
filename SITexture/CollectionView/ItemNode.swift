//
//  ItemNode.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/7.
//

import Foundation

class ItemNode: ASTextCellNode {

    init(string: String) {
        super.init(insets: .zero)
        
        self.text = string
        self.updateBackgroundColor()
    }
    
    func updateBackgroundColor() {
        if self.isHighlighted {
            self.backgroundColor = .gray
        } else if self.isSelected {
            self.backgroundColor = .darkGray
        } else {
            self.backgroundColor = .lightGray
        }
    }
    
    override var isSelected: Bool {
        
        get {
            return super.isSelected
        }
        
        set {
            super.isSelected = newValue
            self.updateBackgroundColor()
        }
    }
    
    override var isHighlighted: Bool {
        
        get {
            return super.isHighlighted
        }
            
        set {
            super.isHighlighted = newValue
            self.updateBackgroundColor()
        }
    }
    
}
