//
//  ProductModel.swift
//  ProductSearch
//
//  Created by Elena Georgieva on 19.11.24.
//

import Foundation
import CoreData

class ProductModel: NSManagedObject {
    
    static let EntityName: String = "Product"
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var information: String
    @NSManaged var thumbnail: String
    
    static func createModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let entity = NSEntityDescription()
        entity.name = ProductModel.EntityName
        entity.managedObjectClassName = NSStringFromClass(ProductModel.self)
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .integer64AttributeType
        idAttribute.isOptional = false
             
        let titleAttribute = NSAttributeDescription()
        titleAttribute.name = "title"
        titleAttribute.attributeType = .stringAttributeType
        titleAttribute.isOptional = false
        
        let informationAttribute = NSAttributeDescription()
        informationAttribute.name = "information"
        informationAttribute.attributeType = .stringAttributeType
        informationAttribute.isOptional = false
        
        let thumbnailAttribute = NSAttributeDescription()
        thumbnailAttribute.name = "thumbnail"
        thumbnailAttribute.attributeType = .stringAttributeType
        thumbnailAttribute.isOptional = false
        
        entity.properties = [idAttribute, titleAttribute, informationAttribute, thumbnailAttribute]
        
        model.entities = [entity]
        
        return model
    }
}
