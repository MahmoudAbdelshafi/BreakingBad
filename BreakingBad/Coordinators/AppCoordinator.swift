//
//  AppCoordinator.swift
//  BreakingBad
//
//  Created by Mahmoud Abdelshafi on 26/06/2021.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let characterListCoordinator = CharacterListCoordinator(navigationController: navigationController)
        
        childCoordinators.append(characterListCoordinator)
        characterListCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
