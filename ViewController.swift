//
//  testVC.swift
//  Saifur_30016_Mid1
//
//  Created by BJIT on 12/1/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var bookmarkCount: Int = 0
    var tableRowIndex = 0
    var selectedIndex  = IndexPath(row: 0, section: 0)
    var cellData = [Article]()
    var categoryName:String = ""
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        JSONHandler.shared.getPost("all" , { result in
            self.cellData  = result.articles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
         */
      
        

        tableView.delegate = self
        tableView.dataSource = self
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        searchBar.addTarget(self, action: #selector(newsFinder), for: .editingChanged)
        
        syncTable("all") { [weak self] in
            CoreDataDB.coreShare.getAllRecord()
            guard let self = self else { return }
            let records = News.newsArray
            self.cellData.removeAll()
            for record in records{
                let source = Source(id: nil, name: record.source)
                let news = Article(source: source, author: record.author, title: record.title, description: record.descript, url: record.url, urlToImage: record.urlToImage, publishedAt: record.publishedAt, content: record.content)
                self.cellData.append(news)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
  @objc func newsFinder(){
        if let keywords = searchBar.text{
            if keywords == "" {
                CoreDataDB.coreShare.getAllRecord()
                refreshNews()
            } else{
                print(categoryName)
                CoreDataDB.coreShare.getRecord(category: categoryName, searchText: keywords)
                //guard let self = self else { return }
                print(categoryName)
                let records = News.newsArray
                self.cellData.removeAll()
                for record in records{
                    let source = Source(id: nil, name: nil) //how it should be modified
                    let news = Article(source: source, author: record.author, title: record.title, description: record.descript, url: record.url, urlToImage: record.urlToImage, publishedAt: record.publishedAt, content: record.content)
                    cellData.append(news)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
                refreshNews()
            }
        }
    }
}



extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("total cell: \(cellData.count)")
        return cellData.count
    
    }
    
   
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        cell.title.text = cellData[indexPath.row].title
        cell.time.text = cellData[indexPath.row].publishedAt
        cell.content.text   = cellData[indexPath.row].content
        cell.thumbnail.sd_setImage(with: URL(string: cellData[indexPath.row].urlToImage ?? "https://cdn.abcotvs.com/dip/images/12685608_meag-millions.jpg?w=1600"), placeholderImage: UIImage(systemName: "pencil") )
        cell.source.text = cellData[indexPath.row].source.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableRowIndex = indexPath.row
        performSegue(withIdentifier: Constant.bookmarksSegueId, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.homeToDetails{
            if let extendedDetails = segue.destination as? ExtendedDetails{
                print(cellData[tableRowIndex].url!)
                extendedDetails.loadViewIfNeeded()
                extendedDetails.newsCompany.text = cellData[tableRowIndex].source.name
                extendedDetails.newsTitle.text = cellData[tableRowIndex].title
                extendedDetails.newsAuthor.text = cellData[tableRowIndex].author
                extendedDetails.newsDate.text = cellData[tableRowIndex].publishedAt
                extendedDetails.newsDescription.text = cellData[tableRowIndex].description
                extendedDetails.storeURL = cellData[tableRowIndex].url!
                extendedDetails.storeImageURL = cellData[tableRowIndex].urlToImage!
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let saveBookmark = UIContextualAction(style: .normal, title: ""){ [weak self]  _,_, _ in
            guard let self = self else {
                            return
            }
            print(indexPath.row)
            print(self.cellData.count)
            self.saveToBookmark(indexPath: indexPath)
            
        }
        let actions = UISwipeActionsConfiguration(actions: [saveBookmark])
        return actions
    }
    
    func saveToBookmark(indexPath: IndexPath){
        
        print(indexPath.row)
        print(self.cellData.count)
       // print("title: \(Constant.category[indexPath.row])", "Not Detected")
        BookmarkDB.bookmarkShare.createBookmarkEntry(author: cellData[indexPath.row].author ?? "not found", content: cellData[indexPath.row].content ?? "Not Found", description: cellData[indexPath.row].description ?? "Not found", name: cellData[indexPath.row].source.name ?? "Not Found", publishedAt: cellData[indexPath.row].publishedAt ?? "Not Found", title: cellData[indexPath.row].title ?? "Not Found", url: cellData[indexPath.row].url ?? "not found", urlToImage: cellData[indexPath.row].urlToImage ?? "not found", source: cellData[indexPath.row].source.name ?? "Not Found")
    }
}



extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constant.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell{
            cell.underLine.backgroundColor = .systemPink
            selectedIndex = indexPath
            categoryName = Constant.category[selectedIndex.row]
            
            collectionView.reloadData()
            print("\(categoryName): from did select")
            syncTable(categoryName) {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } //Table is synced when it is tapped
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell{
            cell.underLine.backgroundColor = .black
        }
        
    }
    
    
    
    func refreshNews(){
        tableView.reloadData()
    }
     
    // MARK: - FUNCTION TO SYNC TABLE
    func syncTable(_ category:String, completion: @escaping () ->  Void){
        APICaller.jsonShare.getPost(category , { result in
            completion()
        })
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "testCategory", for: indexPath) as! CollectionViewCell
        cell.category.text = Constant.category[indexPath.row]
        cell.category.font = UIFont.systemFont(ofSize: 16, weight: .bold)        
        if indexPath == selectedIndex{
            cell.underLine.backgroundColor = .systemPink
        }
        return cell
    }
       
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    
    
}
// MARK: - DEFINE COLLECTIONVIEW SIZE
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 70)
    }
}

     
    


