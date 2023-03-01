//
//  TestBVC.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 13/1/23.
//

import UIKit
import SDWebImage

class BookmarkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var bookmarkIndex = 0
     var bookmarkCell = [Article]()

    @IBOutlet weak var searchTextfield: UITextField!
    
    @IBOutlet weak var newsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable.dataSource = self
        newsTable.delegate = self
        BookmarkDB.bookmarkShare.bookmarkAllRecord()
        
        //bookmarkCell =
        DispatchQueue.main.async {
            self.newsTable.reloadData()
        }
       /* syncBookmark { [weak self] in
            BookmarkDB.bookmarkShare.bookmarkAllRecord()
            guard let self = self else { return }
            let records = News.newsArray
            self.bookmarkCell.removeAll()
            for record in records{
                let source = Source(id: nil, name: record.source)
                let news = Article(source: source, author: record.author, title: record.title, description: record.descript, url: record.url, urlToImage: record.urlToImage, publishedAt: record.publishedAt, content: record.content)
                self.bookmarkCell.append(news)
            }
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }*/
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        BookmarkDB.bookmarkShare.bookmarkAllRecord()
        newsTable.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("bookmark: \(Bookmark.bookmarkArray.count)")
        return Bookmark.bookmarkArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.bookmarksSegueId{
            if let extendedDetails = segue.destination as? ExtendedDetails{
                
                extendedDetails.loadViewIfNeeded()
                extendedDetails.newsCompany.text = Bookmark.bookmarkArray[bookmarkIndex].name
                extendedDetails.newsTitle.text = Bookmark.bookmarkArray[bookmarkIndex].title
                extendedDetails.newsAuthor.text = Bookmark.bookmarkArray[bookmarkIndex].author
                extendedDetails.newsDate.text = Bookmark.bookmarkArray[bookmarkIndex].publishedAt
                extendedDetails.newsDescription.text = Bookmark.bookmarkArray[bookmarkIndex].descript
                extendedDetails.storeURL = Bookmark.bookmarkArray[bookmarkIndex].url!
                extendedDetails.storeImageURL = Bookmark.bookmarkArray[bookmarkIndex].urlToImage!
              
                
            }
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableRow = newsTable.dequeueReusableCell(withIdentifier: "bookmarkTable", for: indexPath) as! BookmarkTableRow
        tableRow.bookmarkTitle.text = Bookmark.bookmarkArray[indexPath.row].title
        tableRow.bookmarkThumbnail.sd_setImage(with: URL(string: Bookmark.bookmarkArray[indexPath.row].urlToImage! ), placeholderImage: UIImage(systemName: "pencil") )
        
       
        return tableRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarkIndex = indexPath.row
        performSegue(withIdentifier: Constant.bookmarksSegueId, sender: nil)
        newsTable.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    
    // MARK: - FUNCTION TO SYNC TABLE
    /*
    func syncBookmark(complition: @escaping ()->Void){
        BookmarkDB.bookmarkShare.getAllRecord()
    }
     */

    

}


