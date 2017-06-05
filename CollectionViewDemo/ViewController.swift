//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Harry PC on 6/5/17.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDataSource ,CollectionViewWaterfallLayoutDelegate{
    @IBOutlet var collectionView: UICollectionView!

    lazy var cellSizes: [CGSize] = {
        var _cellSizes = [CGSize]()
        
        for _ in 0...100 {
            let random = Int(arc4random_uniform((UInt32(100))))
            
            _cellSizes.append(CGSize(width: 140, height: 50 + random))
        }
        
        return _cellSizes
    }()
    
    var imgData : [String]!
    let kHorizontalInsets: CGFloat = 10.0
    let kVerticalInsets: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgData = ["image1","image2","image3","image4","image5","image1","image2","image3","image4","image5","image1","image2","image3","image4","image5"]
        // Do any additional setup after loading the view, typically from a nib.
        
        let layout = CollectionViewWaterfallLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.headerInset = UIEdgeInsetsMake(20, 0, 0, 0)
        layout.headerHeight = 0
        layout.footerHeight = 0
        layout.minimumColumnSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionHeader, withReuseIdentifier: "Header")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: CollectionViewWaterfallElementKindSectionFooter, withReuseIdentifier: "Footer")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        cell.imgView.image = UIImage(named: imgData[indexPath.row])
        cell.imgView.layer.borderColor = UIColor.random().cgColor
        cell.imgView.layer.borderWidth = 2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView: UICollectionReusableView? = nil
        
        if kind == CollectionViewWaterfallElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
            
            if let view = reusableView {
                view.backgroundColor = UIColor.red
            }
        }
        else if kind == CollectionViewWaterfallElementKindSectionFooter {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath)
            if let view = reusableView {
                view.backgroundColor = UIColor.blue
            }
        }
        
        return reusableView!
    }
    
    // MARK: WaterfallLayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let img = UIImage(named: imgData[indexPath.row])
        return CGSize(width: self.collectionView.frame.size.width / 2, height: (img?.size.height)!)
    }

}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}



