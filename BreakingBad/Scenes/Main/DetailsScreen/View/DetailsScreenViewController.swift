//
//  DetailsScreenViewController.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 25/06/2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsScreenViewController: UIViewController {
    
    private var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    private var charachtersList = BehaviorRelay<[Character]>(value: [])
    private let disposeBag = DisposeBag()
    
    //MARK:- IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var forwordBtn: UIButton!
    @IBOutlet private weak var backwordBtn: UIButton!
    @IBOutlet private weak var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        setupCollectionView()
        bindUIButtons()
        setupIntialSelectedCharachter()
        setupCurrentIndexPath(row: indexPath.row)
    }
    
    func passViewControllerRequiredData(charachtersList: Observable<[Character]>, indexPath: IndexPath) {
        charachtersList.subscribe(onNext: { self.charachtersList.accept($0) }).disposed(by: disposeBag)
        self.indexPath.row = indexPath.row
    }
}

//MARK: - UICollectionView

extension DetailsScreenViewController: UICollectionViewDelegateFlowLayout {
    
    private func registerCollectionViewViewCell() {
        collectionView.register(DetailsCollectionViewCell.self)
    }
    
    private func setupCollectionView()  {
        registerCollectionViewViewCell()
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        bindCollectionView()
    }
    
    private func bindCollectionView() {
        charachtersList.asObservable().bind(to: collectionView.rx.items(cellIdentifier: DetailsCollectionViewCell.reuseIdentifier, cellType: DetailsCollectionViewCell.self)) { [self] row, charachter, cell in
            cell.configure(charachter: charachter, totalPagesNumber: self.charachtersList.value.count, currentPage: row)
        }.disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width =  collectionView.bounds.width
        let height = collectionView.bounds.height + 10
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let indexPath = collectionView.indexPathsForVisibleItems.first {
            self.indexPath = indexPath
        }
    }

}

//MARK: - Priavte Functions

extension DetailsScreenViewController {
    
    private func bindUIButtons() {
        forwordBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).bind { [weak self] in
            guard let self = self else { return }
            if (self.indexPath.row + 1) != self.charachtersList.value.count {
                self.setupCurrentIndexPath(row: self.indexPath.row + 1)
                self.indexPath.row += 1
            }
        }.disposed(by: disposeBag)
        
        backwordBtn.rx.tap.throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance).bind { [weak self] in
            guard let self = self else { return }
            if (self.indexPath.row) != 0 {
                self.setupCurrentIndexPath(row: self.indexPath.row - 1)
                self.indexPath.row -= 1
            }
        }.disposed(by: disposeBag)
        
        backBtn.rx.tap.bind { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func setupCurrentIndexPath(row: Int) {
        let rect = self.collectionView.layoutAttributesForItem(at: IndexPath(row: row, section: 0))!.frame
        self.collectionView.scrollRectToVisible(rect, animated: true)
    }
    
    private func setupIntialSelectedCharachter() {
        collectionView.contentSize = CGSize(width: collectionView.bounds.width * CGFloat(charachtersList.value.count), height: collectionView.bounds.height)
        collectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: .bottom, animated: false)
    }
}
