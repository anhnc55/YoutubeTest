//
//  ViewController.swift
//  YoutubeTest
//
//  Created by Anh Nguyen on 05/06/2022.
//

import UIKit
import Combine

class YoutubeViewController: UIViewController {
    private enum Section: Hashable {
        case main
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private var searchController: UISearchController!
    private var resultsController: UIViewController!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Youtube>! = nil
    
    private let searchTextTrigger = PassthroughSubject<String, Never>()
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    // MARK: - Methods
    private func configView() {
        navigationItem.title = "Youtube Search"
            
        tableView.register(ofType: YoutubeCell.self)
        tableView.delegate = self
        configureDataSource()
        
        searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }

    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Youtube>(tableView: tableView) {
            (tableView: UITableView, indexPath: IndexPath, youtube: Youtube) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(ofType: YoutubeCell.self, at: indexPath)
            cell.configCell(youtube)
            return cell
        }
        dataSource.defaultRowAnimation = .fade
    }
    
    private func searchDataSource(_ data: [Youtube]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Youtube>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)

    }
}

// MARK: - UITableViewDelegate
extension YoutubeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        searchController.searchBar.endEditing(true)
    }
}

// MARK: - UISearchBarDelegate
extension YoutubeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.endEditing(true)
        guard let text = searchBar.text else {
            return
        }
        YoutubeAPI.shared.getYoutubeSearchResult(text) { response in
            DispatchQueue.main.async {
                guard let datas = response?.extractVideosFromHTML() else {
                    return
                }
                self.searchDataSource(datas)
            }
        }
    }
}
