//
//  Bookmarks.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 12/1/23.
//
import Foundation
import UIKit
import CoreData

class BookmarkDB{
    static let bookmarkShare = BookmarkDB()
    let bookmarkContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var bookmarkModels = [Bookmark]()
    

    private init() {}
    func bookmarkAllRecord()  {
        do{
            Bookmark.bookmarkArray = try bookmarkContext.fetch(Bookmark.fetchRequest())
            //print("Title",News.newsArray[0].title)

        } catch{
            print(error)
        }
        
        
    }
    
    func createBookmarkEntry(author:String,content:String,description:String,name:String,publishedAt:String,title:String,url:String,urlToImage:String,source:String){
        let bookmarkEntry = Bookmark(context: bookmarkContext)
        bookmarkEntry.author = author
        bookmarkEntry.category =  "not detected"
        bookmarkEntry.content = content
        bookmarkEntry.descript = description
        bookmarkEntry.name = name
        bookmarkEntry.publishedAt = publishedAt
        bookmarkEntry.title = title
        bookmarkEntry.url = url
        bookmarkEntry.urlToImage = urlToImage
        bookmarkEntry.source = source
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("bookmarkdb:\(urls[urls.count-1] as URL)")
        do{
            try bookmarkContext.save()
        } catch{
            print(error.localizedDescription)
        }
    }
    
    func getAllRecord()  {
        do{
            Bookmark.bookmarkArray = try bookmarkContext.fetch(Bookmark.fetchRequest())
            //print("Title",News.newsArray[0].title)

        } catch{
            print(error)
        }
        
        
    }
    
    func getRecord( searchText:String) {
        
        let fetchRequest = NSFetchRequest<Bookmark>(entityName: "Bookmark")
        let format = "title CONTAINS[c] %@"
        let predicate = NSPredicate(format: format, searchText)
        fetchRequest.predicate = predicate
        
        
        do {
            Bookmark.bookmarkArray = try bookmarkContext.fetch(fetchRequest)
            
        } catch {
            print(error)
            
        }
    }
   
    
}
