//
//  CharacterListCoordinator.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 26/06/2021.
//

import UIKit
import RxSwift

final class CharacterListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let characterListVC = CharacterListViewController.instantiate()
        characterListVC.coordinator = self
        navigationController.setViewControllers([characterListVC], animated: true)
    }
    
    func detailsViewControllerSubscription(charachtersList: Observable<[Character]>, indexPath: IndexPath) {
        let detailsScreenVC = DetailsScreenViewController.instantiate()
        detailsScreenVC.passViewControllerRequiredData(charachtersList: charachtersList, indexPath: indexPath)
        navigationController.pushViewController(detailsScreenVC, animated: true)
    }
}
