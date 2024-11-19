//
//  DatabaseManager.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation
import CoreData
import UIKit
 
protocol DatabaseManagertType {
    func update(_ product: Product, completion: (Bool) -> Void)
    func fetchAll(completion: ([Product]) -> Void)
}

class DatabaseManager: DatabaseManagertType {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        return appDelegate.persistentContainer.viewContext
    }
    
    func update(_ product: Product, completion: (Bool) -> Void) {
        fetchProduct(id: product.id) { saved in
            if let saved {
                delete(id: saved.id)
                completion(false)
            } else {
                save(product)
                completion(true)
            }
        }
    }
    
    func fetchAll(completion: ([Product]) -> Void) {
        guard let context else { return }
        
        let fetchRequest = NSFetchRequest<ProductModel>(entityName: ProductModel.EntityName)
        
        do {
            let products = try context.fetch(fetchRequest)
            completion(products.map { Product(id: $0.id, title: $0.title, description: $0.information, thumbnail: $0.thumbnail) })
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    private func fetchProduct(id: Int, completion: (Product?) -> Void) {
        guard let context else { return }
        
        let fetchRequest = NSFetchRequest<ProductModel>(entityName: ProductModel.EntityName)
        let predicate = NSPredicate(format: "id == %d", id)
        
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            let product = try context.fetch(fetchRequest)
            completion(product.first.map { Product(id: $0.id, title: $0.title, description: $0.information, thumbnail: $0.thumbnail) })
        } catch {
            print("Failed to fetch product: \(error)")
        }
    }
    
    private func save(_ product: Product) {
        guard let context else { return }
        
        let newProduct = ProductModel(context: context)
        newProduct.id = product.id
        newProduct.title = product.title
        newProduct.information = product.description
        newProduct.thumbnail = product.thumbnail
        
        do {
            try context.save()
        } catch {
            print("Failed to save product: \(error)")
        }
    }
    
    private func delete(id: Int) {
        guard let context else { return }
        
        let fetchRequest = NSFetchRequest<ProductModel>(entityName: ProductModel.EntityName)
        let predicate = NSPredicate(format: "id == %d", id)
        
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Failed to delete product: \(error)")
        }
    }
}
