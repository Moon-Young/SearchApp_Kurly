//
//  ViewController.swift
//  SearchApp_Kurly
//
//  Created by Moonyoung Kim on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import Then
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    
    private let recentTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        return tableView
    }()
    private let compareTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        return tableView
    }()
    private let resultTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        return tableView
    }()
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "저장소 검색"
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.searchBar.tintColor = UIColor(named: "main_color")
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupDelegate()
        setupLayout()
        setupViews()
        setupTableView()
        
        // MARK: Bind Realm Observable
        self.viewModel.recentSearchTermRealm
            .bind(to: self.recentTableView.rx.items(cellIdentifier: RecentSearchCell.identifier,
                                                    cellType: RecentSearchCell.self)) { tv, tvItem, cell in
                cell.recentSearchTermLabel.text = tvItem.searchTerm
                cell.recentSearchTermDeleteButton.rx.tap
                    .subscribe { [weak self] _ in
                        self?.viewModel.deleteSingleSearchTermRealmUseCase(singleTerm: tvItem)
                    }.disposed(by: cell.disposeBag)
                
            }.disposed(by: disposeBag)
        
        // MARK: Bind Compare
        self.searchController.searchBar.rx.text.orEmpty
            .debounce(RxTimeInterval.microseconds(5),
                      scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe { [weak self] tuple in
                guard let self = self else { return }
                let (_, termKeyword) = tuple
                let filteredSearchTerms = viewModel.recentSearchTermRealm.value.filter {
                    $0.searchTerm?.contains(termKeyword) ?? false
                }
                viewModel.recentSearchTermCompare.accept(filteredSearchTerms)
            }.disposed(by: disposeBag)
        
        // MARK: Bind Compare
        self.viewModel.recentSearchTermCompare
            .bind(to: self.compareTableView.rx.items(cellIdentifier: CompareSearchCell.identifier,
                                                     cellType: CompareSearchCell.self)) { tv, tvItem, cell in
                cell.recentSearchTermLabel.text = tvItem.searchTerm
                // TODO: Commom
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM.dd."
                let str = dateFormatter.string(from: tvItem.insertDate!)
                cell.recentSearchInsertDateLabel.text = str
            }.disposed(by: disposeBag)
        
        // MARK: Bind API DATA
        self.viewModel.repositoryResultObservable
            .observe(on: MainScheduler.instance)
            .bind(to: self.resultTableView.rx.items(cellIdentifier: ResultSearchCell.identifier,
                                                    cellType: ResultSearchCell.self)) { tv, tvItem, cell in
                cell.resultTitleLabel.text = tvItem.name
                cell.resultDescriptionLabel.text = tvItem.repositoryOwnerResponseDTO.description
                cell.thumbnailImageView.kf.setImage(with: URL(string: tvItem.repositoryOwnerResponseDTO.thumbnail))
            }.disposed(by: disposeBag)
        
        // MARK: Bind API MORE DATA
        self.resultTableView.rx.contentOffset
            .map { offset in
                return self.resultTableView.isNearToBottomEdge(contentOffset: offset,
                                                               distance: 800)
            }.distinctUntilChanged()
            .subscribe {
                return self.viewModel.isNearToBottom.accept($0)
            }.disposed(by: disposeBag)
        
        self.viewModel.isNearToBottom
            .filter { isNear in
                return isNear
            }.subscribe {
                if $0 {
                    self.viewModel.searchMoreAPI()
                }
            }.disposed(by: disposeBag)
        
        // MARK: Bind SELECTED recentTableView TABLE VIEW CELL
        recentTableView.rx.itemSelected
            .map {
                return self.viewModel.recentSearchTermRealm.value[$0.row].searchTerm ?? ""
            }.subscribe {
                self.viewModel.repositoryResultObservable.accept([])
                self.resultTableView.reloadData()
                self.searchController.searchBar.resignFirstResponder()
                self.searchController.searchBar.text = $0
                self.viewModel.addSearchTermRealmUseCase(keyword: $0)
                self.viewModel.searchAPI(keyword: $0)
                self.controlTableView(table: 3)
            }
        
        // MARK: Bind SELECTED compareTableView TABLE VIEW CELL
        compareTableView.rx.itemSelected
            .map {
                return self.viewModel.recentSearchTermCompare.value[$0.row].searchTerm ?? ""
            }.subscribe {
                self.viewModel.repositoryResultObservable.accept([])
                self.resultTableView.reloadData()
                self.searchController.searchBar.resignFirstResponder()
                self.searchController.searchBar.text = $0
                self.viewModel.addSearchTermRealmUseCase(keyword: $0)
                self.viewModel.searchAPI(keyword: $0)
                self.controlTableView(table: 3)
                
            }
        
        // MARK: Bind SELECTED resultTableView TABLE VIEW CELL
        resultTableView.rx.itemSelected
            .map {
                return self.viewModel.repositoryResultObservable.value[$0.row].repositoryOwnerResponseDTO.url
            }.subscribe {
                let webVC = WebViewController()
                webVC.url = URL(string: $0)
                self.present(webVC, animated: true)
            }.disposed(by: disposeBag)
        
    }
    
    private func bindViewModel() {
        self.viewModel.getSearchTermRealmUseCase()
    }
    private func setupDelegate() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.recentTableView.delegate = self
        self.compareTableView.delegate = self
        self.resultTableView.delegate = self
    }
    private func setupLayout() {
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    private func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.recentTableView)
        self.view.addSubview(self.compareTableView)
        self.view.addSubview(self.resultTableView)
    }
    private func setupTableView() {
        
        self.recentTableView.register(RecentSearchCell.self,
                                      forCellReuseIdentifier: RecentSearchCell.identifier)
        self.recentTableView.register(RecentSearchFooterViewCell.self,
                                      forHeaderFooterViewReuseIdentifier: RecentSearchFooterViewCell.identifier)
        self.recentTableView.register(RecentSearchHeaderViewCell.self,
                                      forHeaderFooterViewReuseIdentifier: RecentSearchHeaderViewCell.identifier)
        
        self.compareTableView.register(CompareSearchCell.self,
                                       forCellReuseIdentifier: CompareSearchCell.identifier)
        
        self.resultTableView.register(ResultSearchCell.self,
                                      forCellReuseIdentifier: ResultSearchCell.identifier)
        
        self.recentTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        self.compareTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        self.resultTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Search Controller
extension SearchViewController {
    @objc func deleteAllRealmData() {
        self.viewModel.deleteAllSearchTermRealmUseCase()
    }
    // MARK: Empty TableView Control
    // TODO:
    func controlTableView(table: Int) {
        if table == 1 {
            DispatchQueue.main.async {
                
                self.recentTableView.isHidden = false
                self.compareTableView.isHidden = true
                self.resultTableView.isHidden = true
            }
        } else if table == 2 {
            DispatchQueue.main.async {
                self.recentTableView.isHidden = true
                self.compareTableView.isHidden = false
                self.resultTableView.isHidden = true
            }
        } else {
            DispatchQueue.main.async {
                self.recentTableView.isHidden = true
                self.compareTableView.isHidden = true
                self.resultTableView.isHidden = false
            }
        }
    }
}

// MARK: UISearchControllerDelegate
extension SearchViewController: UISearchControllerDelegate {
    func didDismissSearchController(_ searchController: UISearchController) {
        self.controlTableView(table: 1)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.controlTableView(table: 2)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        self.viewModel.addSearchTermRealmUseCase(keyword: searchText)
        self.viewModel.searchAPI(keyword: searchText)
        self.controlTableView(table: 3)
    }
}

// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == recentTableView {
            return RecentSearchCell.cellHeight
        } else if tableView == compareTableView {
            return CompareSearchCell.cellHeight
        } else {
            return ResultSearchCell.cellHeight
        }
    }
    
    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if tableView == recentTableView {
            let cell = self.recentTableView.dequeueReusableHeaderFooterView(withIdentifier: RecentSearchHeaderViewCell.identifier) as! RecentSearchHeaderViewCell
            cell.headerTextLabel.text = "최근 검색"
            return cell
        } else if tableView == compareTableView {
            return nil
        } else {
            let cell = self.recentTableView.dequeueReusableHeaderFooterView(withIdentifier: RecentSearchHeaderViewCell.identifier) as! RecentSearchHeaderViewCell
            
            // TODO: COMMON
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: self.viewModel.repositoryTotalCount.value)) ?? "0"
            
            DispatchQueue.main.async {
                cell.headerTextLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
                cell.headerTextLabel.textColor = UIColor(named: "main_gray_6")
                cell.headerTextLabel.text = "\(result)개 저장소"
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == recentTableView {
            return RecentSearchHeaderViewCell.cellHeight
        } else if tableView == compareTableView {
            return 0
        } else {
            return RecentSearchHeaderViewCell.cellHeight
        }
    }
    // MARK: Footer
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if tableView == recentTableView {
            let cell = self.recentTableView.dequeueReusableHeaderFooterView(withIdentifier: RecentSearchFooterViewCell.identifier) as! RecentSearchFooterViewCell
            cell.recentSearchTermAllDeleteButton.addTarget(self, action: #selector(deleteAllRealmData), for: .touchUpInside)
            return cell
        } else if tableView == compareTableView {
            return nil
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == recentTableView {
            return RecentSearchFooterViewCell.cellHeight
        } else if tableView == compareTableView {
            return 0
        } else {
            return 0
        }
    }
}

