//
//  ViewController.swift
//  Store
//
//  Created by Abdenoure Boudlal on 4/3/23.
//

import UIKit

class MainViewController: UIViewController {

    

    var networkManager = NetworkManager()
    var productArray = [ProductsModel]()
    var categoryListe = [Category]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var randomProductImage: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var descriptionProductLight: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
//            categoryCollection.register(cellNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
//        self.collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        categoryCollection.dataSource = self
        categoryCollection.delegate = self
//        self.categoryCollection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryCollectionViewCell")

        self.networkManager.fetchDataFromAPI { category in
            
            self.categoryListe = category
            DispatchQueue.main.async {
                self.categoryCollection.reloadData()
            }
        }



        tableView.dataSource = self
        tableView.delegate = self

        self.networkManager.fetchProductsData {
            result in
            switch result{
            case .success( let items):
                self.productArray = items
                DispatchQueue.main.async {

                    self.updateUi(item: items)
//                    print(self.productArray)
                    self.tableView.reloadData()
                }

            case .failure(_):
                print(Error.self)
            }
        }
    }
    
    func updateUi(item:[ProductsModel]){
        let randomItem = item.randomElement()
        nameProduct.text = randomItem?.title
        descriptionProductLight.text = randomItem?.description
        //DispatcœhQueue.global().async{
        let url = URL(string: randomItem?.image ?? "")!
        if let data = try? Data(contentsOf: url){
            randomProductImage.image = UIImage(data: data)
        }
//        self.randomProductImage.image = UIImage(named: randomItem?.image ?? "")
        //}

    }

    @IBAction func shopNowButtonPressed(_ sender: UIButton) {
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCellController", for: indexPath) as? MainTableViewCellController
        else {
            return UITableViewCell()
        }
//        cell.categoryItemCollection.delegate = MainTableViewCellController()
//        cell.categoryItemCollection.dataSource = MainTableViewCellController()
        cell.categoryName.text = categoryListe[indexPath.row].category
        
        DispatchQueue.main.async {
            cell.productArray = self.productArray
        
        cell.categoryItemCollection.reloadData()
        }
        return cell
    }
    
}


extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryListe.count
}

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }

        let product = categoryListe[indexPath.row]
        
        if let label = cell.categoryLabelName {
            label.text = product.category
        }
        switch product.category{
        case "electronics" :
            cell.categoryLabelImage.image = UIImage(named: "electonic")
        case "jewelery" :
            cell.categoryLabelImage.image = UIImage(named: "jewelery01")
        case "men's clothing" :
            cell.categoryLabelImage.image = UIImage(named: "men-cloth01")
        case "women's clothing" :
            cell.categoryLabelImage.image = UIImage(named: "woman-cloth01")
        default:
            cell.categoryLabelImage.image = UIImage(named: "texture-flower-orange-red-color-macro-1110078-pxhere.com")
        }
        
        
        return cell
    }

}
