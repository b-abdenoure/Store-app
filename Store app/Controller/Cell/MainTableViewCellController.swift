//
//  MainTableViewController.swift
//  Store app
//
//  Created by Boudlal Abdenoure on 23/9/2023.
//

import UIKit

class MainTableViewCellController: UITableViewCell {

    var networkManager = NetworkManager()
    var productData: [ProductsModel] = []
    var productElectronicCategory: [ProductsModel] = []

    @IBOutlet weak var categoryName: UILabel!
    
    @IBAction func seeAll(_ sender: UIButton) {
    }
    
    @IBOutlet weak var categoryItemCollection: UICollectionView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
//        categoryItemCollection.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")

    categoryItemCollection.delegate = self
    categoryItemCollection.dataSource = self
//        print(productArray)
//    categoryItemCollection.reloadData()
        self.networkManager.fetchElectronicsCategoryData {
            result in
            switch result{
            case .success( let items):
                self.productElectronicCategory = items
                DispatchQueue.main.async {
//                    print(self.productArray)
                    self.categoryItemCollection.reloadData()
                }

            case .failure(_):
                print(Error.self)
            }
        }

    }
    
}

extension MainTableViewCellController: UICollectionViewDataSource, UICollectionViewDelegate{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return min(3, productArray.count)
//        print(productData.count)

        return productElectronicCategory.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let product = productElectronicCategory[indexPath.row]
//        print(product)
        
//        let product = productArray[indexPath.row]
//cell.categoryLabelImage.image = UIImage(named: product.image)

//        if let uiimage = cell.imageProduct{
//            uiimage.image = UIImage(named: product.image)
//        }
        
//        if let label = cell.productName {
//                label.text = product.title ?? "Unknown"
////            print(label.text!)
//        }
            cell.productName.text? = product.title
        DispatchQueue.main.async {
            let url = URL(string: product.image)!
            if let data = try? Data(contentsOf: url) {
                cell.imageProduct.image = UIImage(data: data)
            }
        }
//        cell.imageProduct.image = UIImage(named: product.image)
        cell.layer.cornerRadius = 5
//        cell.backgroundColor = .lightGray
        return cell
    }
    
    
}
