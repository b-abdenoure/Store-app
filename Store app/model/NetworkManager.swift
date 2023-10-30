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
    
    func fetchProductsData(completionHandler: @escaping (Result<[ProductsModel], Error>) -> Void){
        let url = URL(string: productURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //print(data)
            guard let data = data else {return}
            
            do {
                
                let postsData = try JSONDecoder().decode([ProductsModel].self, from: data)
//                print(postsData)
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
    
//    func fetchCategoryList(completion: @escaping (Result<[CategoryModel],Error>) -> Void){
//        let url = URL(string: categoryURL)!
//        let task = URLSession.shared.dataTask(with: url){ (data, response , error)in
//            guard let data = data else {return}
//            do{
//                let category = try JSONDecoder().decode([CategoryModel].self, from: data)
//                completion(.success(category))
//                print(category)
//            }catch{
//                let error = Error.self
//                completion(.failure(error as! Error))
//
//            }
//        }
//        task.resume()
//    }
    
//    func fetchCategoryList(completion: @escaping (Result<[CategoryModel], Error>) -> Void) {
//        let url = URL(string: categoryURL)!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                // Handle network request error
//                completion(.failure(error))
//                return
//            }
//
//            guard let data = data else {
//                let dataError = NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Data is nil"])
//                completion(.failure(dataError))
//                return
//            }
//
//            do {
//
//                let postsData = try JSONDecoder().decode([CategoryModel].self, from: data)
////                print(postsData)
//                completion(.success(postsData))
//
//            }
//            catch{
//                let error = Error.self
//                completion(.failure(error ))
//                //print(String(describing: error))
//
//            }
//
////            do {
////                let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
////                completion(.success(categories))
////                print(categories)
////            } catch {
////                // Handle JSON decoding error
////                completion(.failure(error))
////            }
//        }
//        task.resume()
//    }

//    func fetchCategoryList(completion: @escaping ([CategoryModel]) -> Void) {
//        let url = URL(string: categoryURL)!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            guard let data = data else {
//                return
//            }
//            do {
//                // Decode JSON data into an array of CategoryModel
//                let categories = try JSONDecoder().decode([CategoryModel].self, from: data)
//                completion(categories)
//                print(categories)
//            }
//            catch {
//                print(error)
//            }
//        }
//        task.resume()
//    }
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
                
               
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }.resume()
    }


    
}
