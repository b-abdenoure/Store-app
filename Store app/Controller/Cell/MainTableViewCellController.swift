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
    var productJeweleryCategory: [ProductsModel] = []
    var productMensClothingCategory: [ProductsModel] = []
    var productWomensClothingCategory: [ProductsModel] = []
    
//    var fetchedCategoryCount = 0

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
//                self.fetchedCategoryCount += 1

//                               if self.fetchedCategoryCount == 4 {
                                   DispatchQueue.main.async {
                                       self.categoryItemCollection.reloadData()
                                   }
//                               }

            case .failure(_):
                print(Error.self)
            }
        }
//        print(self.productElectronicCategory)
        self.networkManager.fetchJeweleryCategoryData {
            result in
            switch result{
            case .success( let items):
                self.productJeweleryCategory = items
//                self.fetchedCategoryCount += 1

//                               if self.fetchedCategoryCount == 4 {
                                   DispatchQueue.main.async {
                                       self.categoryItemCollection.reloadData()
                                   }
//                               }

            case .failure(_):
                print(Error.self)
            }
        }
        self.networkManager.fetchMensClothingCategoryData {
            result in
            switch result{
            case .success( let items):
                self.productMensClothingCategory = items
//                self.fetchedCategoryCount += 1

//                               if self.fetchedCategoryCount == 4 {
                                   DispatchQueue.main.async {
                                       self.categoryItemCollection.reloadData()
                                   }
//                               }
            case .failure(_):
                print(Error.self)
            }
        }
        self.networkManager.fetchWomensClothingCategoryData {
            result in
            switch result{
            case .success( let items):
                self.productWomensClothingCategory = items
//                self.fetchedCategoryCount += 1

//                               if self.fetchedCategoryCount == 4 {
                                   DispatchQueue.main.async {
                                       self.categoryItemCollection.reloadData()
                                   }
//                               }

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
//return productElectronicCategory.count
        switch categoryName.text{
        case "electronics":
            return productElectronicCategory.count
        case "jewelery":
            return productJeweleryCategory.count
        case "men's clothing":
            return productMensClothingCategory.count
        case "women's clothing":
            return productWomensClothingCategory.count
        default:
            return 0
    }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell
        else {
            return UICollectionViewCell()
        }



//
        //        let electronicsProduct = productElectronicCategory[indexPath.row]
        //        let jeweleryProduct = productJeweleryCategory[indexPath.row]
        //        let mensClothingProduct = productMensClothingCategory[indexPath.row]
        //        let womensClothingProduct = productWomensClothingCategory[indexPath.row]

        DispatchQueue.main.async {
            switch self.categoryName.text{
        case "electronics":
                print("Configuring cell for electronics")
                let product = self.productElectronicCategory[indexPath.row]
            cell.productName.text? = product.title
            DispatchQueue.main.async {
                let url = URL(string: product.image)!
                if let data = try? Data(contentsOf: url) {
                    cell.imageProduct.image = UIImage(data: data)
                }
            }
        case "jewelery":
                print("Configuring cell for jewelery")
                let product = self.productJeweleryCategory[indexPath.row]
            cell.productName.text? = product.title
            DispatchQueue.main.async {
                let url = URL(string: product.image)!
                if let data = try? Data(contentsOf: url) {
                    cell.imageProduct.image = UIImage(data: data)
                }
            }
        case "men's clothing":
                print("Configuring cell for men's clothing")
                let product = self.productMensClothingCategory[indexPath.row]
            cell.productName.text? = product.title
            DispatchQueue.main.async {
                let url = URL(string: product.image)!
                if let data = try? Data(contentsOf: url) {
                    cell.imageProduct.image = UIImage(data: data)
                }
            }
        case "women's clothing":
                print("Configuring cell for women's clothing")
                let product = self.productWomensClothingCategory[indexPath.row]
            cell.productName.text? = product.title
            DispatchQueue.main.async {
                let url = URL(string: product.image)!
                if let data = try? Data(contentsOf: url) {
                    cell.imageProduct.image = UIImage(data: data)
                }
            }
        default:
            break
        }
        }

//        cell.imageProduct.image = UIImage(named: product.image)
        cell.layer.cornerRadius = 5
//        cell.backgroundColor = .lightGray
        return cell
    }
//   
}
