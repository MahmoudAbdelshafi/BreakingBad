//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 24/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class CharacterListViewController: UIViewController {
    
    //MARK:- Properties
    
    private var viewModel = CharacterListViewModel(characterListRepo: CharacterListRepoImpl())
    private let disposeBag = DisposeBag()
    
    weak var coordinator: CharacterListCoordinator?
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var mainScrollView: UIScrollView!
    @IBOutlet private weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        viewModel.getCharacters()
    }
    
}

//MARK: - UICollectionView

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    
    private func registerCollectionViewViewCell() {
        collectionView.register(HomeHeaderCollectionViewCell.self)
    }
    
    private func setupCollectionView()  {
        registerCollectionViewViewCell()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        viewModel.headerImages.asObservable().bind(to: collectionView.rx.items(cellIdentifier: HomeHeaderCollectionViewCell.reuseIdentifier, cellType: HomeHeaderCollectionViewCell.self)) { row, headerImage, cell in
            cell.configure(image: headerImage)
        }.disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 50
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

//MARK:- UITableViewDelegate

extension CharacterListViewController: UITableViewDelegate {
    
    private func registerTableViewCell() {
        tableView.register(CharacterTableViewCell.self)
    }
    
    private func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        registerTableViewCell()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
    }
    
    private func bindTableView() {
        viewModel.characters.bind(to: tableView.rx.items) {(tableView, row, charachter) -> UITableViewCell in
            let cell = tableView.dequeueReusableCell(forIndexPath: IndexPath.init(row: row, section: 0)) as CharacterTableViewCell
            cell.configure(charachter: charachter)
            return cell
        }.disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance), tableView.rx.modelSelected(Character.self))
            .bind { [unowned self] indexPath, userRepository in
                self.tableView.deselectRow(at: indexPath, animated: true)
                coordinator?.detailsViewControllerSubscription(charachtersList: viewModel.characters, indexPath: indexPath)
            }.disposed(by: disposeBag)
    }
}

//MARK:- Private Functions

extension CharacterListViewController {
    
    private func setupUI() {
        setupTableView()
        setupCollectionView()
        mainScrollView.delegate = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupBindings() {
        bindTableView()
        
        viewModel.loading
            .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        self.viewModel.characters.subscribe(onNext: { [weak self] in
            self?.tableViewHeightConstraint.constant = CGFloat(($0.count * 88)) /// 88 is the TableViewCell static height
        }).disposed(by: disposeBag)
        
        self.viewModel.errorMessage.subscribe(onNext: { [weak self] errorMessage in
            self?.showAlert(title: "", message: errorMessage, actionTitle: "Retry") {
                self?.viewModel.getCharacters()
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - UIScrollView

extension CharacterListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// Ignore collectionview horizontal scrolling and tableview scrolling
        if scrollView != tableView && scrollView != collectionView {
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                viewModel.getCharacters()
            }
        }
    }
}
