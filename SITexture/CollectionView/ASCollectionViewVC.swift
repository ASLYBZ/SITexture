//
//  ASCollectionViewVC.swift
//  SITexture
//
//  Created by 王卫亮 on 2022/12/6.
//

import UIKit

let kItemSize = CGSize.init(width: 180, height: 90)
let ASYNC_COLLECTION_LAYOUT = 0

class ASCollectionViewVC: BaseVC {
   
    
    
    var collectionNode: ASCollectionNode? = nil
    var data: [[String]] = []
    var moveRecognizer = UILongPressGestureRecognizer.init(target: self, action: #selector(handleLongPress))

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.addGestureRecognizer(self.moveRecognizer)
        
        if ASYNC_COLLECTION_LAYOUT == 1 {
            let layoutDelegate = ASCollectionGalleryLayoutDelegate.init(scrollableDirections: ASScrollDirectionVerticalDirections)
            layoutDelegate.propertiesProvider = self
            self.collectionNode = ASCollectionNode.init(layoutDelegate: layoutDelegate, layoutFacilitator: nil)
        } else {
            let layout = UICollectionViewFlowLayout.init()
            layout.headerReferenceSize = CGSize.init(width: 50, height: 50)
            layout.footerReferenceSize = CGSize.init(width: 50, height: 50)
            layout.itemSize = kItemSize
            self.collectionNode = ASCollectionNode.init(frame: self.view.bounds, collectionViewLayout: layout)
            self.collectionNode?.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionHeader)
            self.collectionNode?.registerSupplementaryNode(ofKind: UICollectionView.elementKindSectionFooter)
        }
        
        self.collectionNode?.dataSource = self
        self.collectionNode?.delegate = self
        
        self.collectionNode?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.collectionNode?.backgroundColor = .white
        
        self.view.addSubnode(self.collectionNode!)
        self.collectionNode?.frame = self.view.bounds
        
        
        self.loadData()
        
        self.reloadTapped()
    }
    
    func loadData() {
        var data = [[String]]()
        for i in 0..<100 {
            var items = [String]()
            for j in 0..<10 {
                items.append("[\(i).\(j)] says hi")
            }
            data.append(items)
        }
        
        self.data = data;
    }
    
    func reloadTapped() {
        self.collectionNode?.reloadData()
    }

    
    @objc func handleLongPress() {
        
    }

}

extension ASCollectionViewVC: ASCollectionGalleryLayoutPropertiesProviding {
    
    func galleryLayoutDelegate(_ delegate: ASCollectionGalleryLayoutDelegate, sizeForElements elements: ASElementMap) -> CGSize {
        return kItemSize
    }
}


extension ASCollectionViewVC: ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let text = self.data[indexPath.section][indexPath.item]
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = ItemNode.init(string: text)
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNode {
        let text = kind == UICollectionView.elementKindSectionHeader ? "Header" : "Footer"
        let node = SupplementaryNode.init().set(text: text)
        let isHeaderSection = kind == UICollectionView.elementKindSectionHeader
        node.backgroundColor = isHeaderSection ? .blue : .red
        return node
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return self.data[section].count
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return self.data.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, canMoveItemWith node: ASCellNode) -> Bool {
        return true
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var sectionArray = self.data[sourceIndexPath.section]
        let object = sectionArray[sourceIndexPath.item]
        sectionArray.remove(at: sourceIndexPath.item)
        self.data[destinationIndexPath.section].insert(object, at: destinationIndexPath.item)
    }
    
}

extension ASCollectionViewVC: ASCollectionDelegate {
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        context.completeBatchFetching(true)
    }
    
}
