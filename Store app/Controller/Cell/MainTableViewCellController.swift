//
//  MainTableViewController.swift
//  Store app
//
//  Created by Boudlal Abdenoure on 23/9/2023.
//

import UIKit

class MainTableViewCellController: UITableViewCell {

    var productArray = [ProductsModel]()
    @IBOutlet weak var categoryName: UILabel!
    
    
    
    @IBAction func seeAll(_ sender: UIButton) {
    }
    
    @IBOutlet weak var categoryItemCollection: UICollectionView!
    
}

extension MainTableViewCellController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
////        let size = (collectionView.frame.size.width ) / 0.8
//        return CGSize(width: 150, height: 150)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return min(3, productArray.count)
        return productArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let product = productArray[indexPath.row]
        print(product)
//        cell.configure(with: product)
        
//        let product = productArray[indexPath.row]
//cell.categoryLabelImage.image = UIImage(named: product.image)
        
        cell.imageProduct.image = UIImage(named: product.image)
        cell.layer.cornerRadius = 5
//        cell.backgroundColor = .lightGray
        return cell
    }
    
    
}
