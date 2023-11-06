//
//  NetworkManager.swift
//  Store app
//
//  Created by Boudlal Abdenoure on 24/9/2023.
//

import UIKit

struct NetworkManager{
    
    
    let productURL = "https://fakestoreapi.com/products"
    let categoryURL = "https://fakestoreapi.com/products/categories"
    let electronicsCategoryURL = "https://fakestoreapi.com/products/category/electronics"
    let jeweleryCategoryURL = "https://fakestoreapi.com/products/category/jewelery"
    let mensClothingCategoryURL = "https://fakestoreapi.com/products/category/men's%20clothing"
    let womensClothingCategoryURL = "https://fakestoreapi.com/products/category/women's%20clothing"

    func fetchProductsData(completionHandler: @escaping (Result<[ProductsModel], Error>) -> Void){
        let url = URL(string: productURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(data)
            guard let data = data else {return}
            
            do {
                
                let postsData = try JSONDecoder().decode([ProductsModel].self, from: data)
//                print(postsData)
                completionHandler(.success(postsData))
            }
            catch{
                let error = Error.self
                completionHandler(.failure(error as! Error))
                //print(String(describing: error))
            }
        }
        
        task.resume()
    }
    
    func fetchProductsCategoryData(myUrl: String ,completionHandler: @escaping (Result<[ProductsModel], Error>) -> Void){
        let url = URL(string: myUrl)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(data)
            guard let data = data else {return}
            
            do {
                let postsData = try JSONDecoder().decode([ProductsModel].self, from: data)
//                print(postsData)
                completionHandler(.success(postsData))
            }
            catch{
                let error = Error.self
                completionHandler(.failure(error as! Error))
                //print(String(describing: error))
            }
        }
        task.resume()
    }

    func fetchDataFromAPI(completion: @escaping([Category])->Void)  {
        guard let url = URL(string: categoryURL) else {
            return
        }
        URLSession.shared.dataTask(with: url) {  (data, _, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let categories = try JSONDecoder().decode([String].self, from: data)
                let categoryList = categories.map { Category(category: $0) }
                completion(categoryList)
                print(categoryList)
               
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }
}
