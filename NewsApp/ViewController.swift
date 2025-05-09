//
//  ViewController.swift
//  NewsApp
//
//  Created by Vaibhav  Tiwary on 26/04/25.
//

import UIKit
import SafariServices

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate, UISearchControllerDelegate{
    
    
    private let tableView:UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier:NewsTableViewCell.identifier)
        return table
        
        
    }()
    
    private let searchVC  = UISearchController(searchResultsController: nil)
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        fetchTopStories()
        createSearchBar()
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
        
      
    }
    
    private func createSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        searchVC.delegate = self
    }
    
    private func fetchTopStories(){
        APICaller.shared.getTopStories{[weak self] result in
            
            
            switch result{
                case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        substitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                case .failure(let error):
                print(error)
                    break
                    
                }
            }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath)as? NewsTableViewCell else{
            fatalError()
            
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
        
    }
//    m, kfc 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "")else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.search(with:text){[weak self] result in
            
            
            switch result{
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                        title: $0.title,
                        substitle: $0.description ?? "No Description",
                        imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true)
                }
            case .failure(let error):
                print(error)
                break
                
            }
        }
    }
            
        
       
    }
    
    



