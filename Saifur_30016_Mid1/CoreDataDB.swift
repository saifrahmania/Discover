//
//  CoreDataHandler.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 17/1/23.
//

import Foundation
import UIKit
import CoreData



class CoreDataDB{
    static let coreShare = CoreDataDB()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var models = [News]()

    private init() {}

    //return All data from the persistant container
    func getAllRecord()  {
        do{
            News.newsArray = try context.fetch(News.fetchRequest())
            //print("Title",News.newsArray[0].title)

        } catch{
            print(error)
        }
        
        
    }

    func createEntry(author:String,category:String,content:String,description:String,name:String,publishedAt:String,title:String,url:String,urlToImage:String,source:String){
        let newsEntry = News(context: context)
        newsEntry.author = author
        newsEntry.category = category
        newsEntry.content = content
        newsEntry.descript = description
        newsEntry.name = name
        newsEntry.publishedAt = publishedAt
        newsEntry.title = title
        newsEntry.url = url
        newsEntry.urlToImage = urlToImage
        newsEntry.source = source
        
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
       
       /* DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            
            do{
                try self.context.save()
            } catch{
                print(error.localizedDescription)
            }



        }*/
        
    }
    
 /*   func getRecord(category:String, searchText:String) ->[News]?{
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        let format = "categoryName = %@ && title CONTAINS[c] %@"
        let predicate = NSPredicate(format: format, category,searchText)
        fetchRequest.predicate = predicate
        
        var result: [News]?
        do {
            result = try context.fetch(fetchRequest)
            return result
        } catch {
            print(error)
            return nil
        }
    } */
    func getRecord(category:String, searchText:String) {
        print("from get rec: a\(category)")
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        let format = "category = %@ && title CONTAINS[c] %@"
        let predicate = NSPredicate(format: format, category,searchText)
        fetchRequest.predicate = predicate
        
        
        do {
            News.newsArray = try context.fetch(fetchRequest)
            
        } catch {
            print(error)
            
        }
    }
    
    func deleteAll(){
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "News")
            let allDelete = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(allDelete)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }

    
}
