//
//  MainTableViewController.swift
//  Store app
//
//  Created by Boudlal Abdenoure on 23/9/2023.
//

import UIKit

class MainTableViewCellController: UITableViewCell {

    var productArray: [ProductsModel] = []

    @IBOutlet weak var categoryName: UILabel!
    
    @IBAction func seeAll(_ sender: UIButton) {
    }
    
    @IBOutlet weak var categoryItemCollection: UICollectionView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        categoryItemCollection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")

    categoryItemCollection.delegate = self
    categoryItemCollection.dataSource = self
//        print(productArray)
//    categoryItemCollection.reloadData()

    }
    
}

extension MainTableViewCellController: UICollectionViewDataSource, UICollectionViewDelegate{


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
//        print(product)
        
//        let product = productArray[indexPath.row]
//cell.categoryLabelImage.image = UIImage(named: product.image)

//        if let uiimage = cell.imageProduct{
//            uiimage.image = UIImage(named: product.image)
//        }
        if let label = cell.productName {
                label.text = product.title ?? "Unknown"
            print(label.text!)
        }
//            cell.productName.text? = product.title
        
//        cell.imageProduct.image = UIImage(named: product.image)
        cell.layer.cornerRadius = 5
//        cell.backgroundColor = .lightGray
        return cell
    }
    
    
}
