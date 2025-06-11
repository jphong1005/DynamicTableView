//
//  Coordinator.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/2/25.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start() -> Void
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        mainCoordinator.start()
    }
}

class MainCoordinator: Coordinator, MainViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainVC = MainViewController()
        mainVC.delegate = self
        self.navigationController.viewControllers = [mainVC]
    }
    
    func goToMyTableView() {
        let tableViewCoordinator = TableViewCoordinator(navigationController: navigationController)
        tableViewCoordinator.parent = self
        tableViewCoordinator.start()
        self.childCoordinators.append(tableViewCoordinator)
          print("Before: \(childCoordinators)")
    }
    
    func goToMyCollectionViewFlowLayout() {
        let collectionViewFlowLayoutCoordinator = CollectionViewFlowLayoutCoordinator(navigationController: navigationController)
        collectionViewFlowLayoutCoordinator.parent = self
        collectionViewFlowLayoutCoordinator.start()
        self.childCoordinators.append(collectionViewFlowLayoutCoordinator)
        print("Before: \(childCoordinators)")
    }
    
    func goToMyCollectionViewCompositionalLayout() {
        let collectionViewCompositionalLayoutCoordinator = CollectionViewCompositionalLayoutCoordinator(navigationController: navigationController)
        collectionViewCompositionalLayoutCoordinator.parent = self
        collectionViewCompositionalLayoutCoordinator.start()
        self.childCoordinators.append(collectionViewCompositionalLayoutCoordinator)
        print("Before: \(childCoordinators)")
    }
    
    func removeChild(coordinator: Coordinator?) -> Void {
        self.childCoordinators = self.childCoordinators.filter { $0 !== coordinator }
          print("After: \(childCoordinators)")
    }
}

class TableViewCoordinator: Coordinator, MyTableViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    weak var parent: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myTableVC = MyTableViewController()
        myTableVC.delegate = self
        self.navigationController.pushViewController(myTableVC, animated: true)
    }
    
    func willDisappear() {
        self.parent?.removeChild(coordinator: self)
    }
}

class CollectionViewFlowLayoutCoordinator: Coordinator, MyCollectionViewFlowLayoutViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    weak var parent: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myCollectionFlowLayoutVC = MyCollectionViewFlowLayoutViewController()
        myCollectionFlowLayoutVC.delegate = self
        self.navigationController.pushViewController(myCollectionFlowLayoutVC, animated: true)
    }
    
    func willDisappear() {
        self.parent?.removeChild(coordinator: self)
    }
}

class CollectionViewCompositionalLayoutCoordinator: Coordinator, MyCollectionViewCompositionalLayoutViewControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    weak var parent: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let myCollectionViewCompositionalLayoutVC = MyCollectionViewCompositionalLayoutViewController()
        myCollectionViewCompositionalLayoutVC.delegate = self
        self.navigationController.pushViewController(myCollectionViewCompositionalLayoutVC, animated: true)
    }
    
    func willDisappear() {
        self.parent?.removeChild(coordinator: self)
    }
}
