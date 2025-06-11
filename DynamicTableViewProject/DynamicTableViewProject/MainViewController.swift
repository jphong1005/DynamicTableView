//
//  EntryViewController.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/2/25.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    func goToMyTableView() -> Void
    func goToMyCollectionViewFlowLayout() -> Void
    func goToMyCollectionViewCompositionalLayout() -> Void
}

class MainViewController: UIViewController {

    var delegate: MainViewControllerDelegate?
    
    lazy var tableViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Table View", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapTableViewButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionViewFlowLayoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Collection View (Flow-Layout)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapCollectionViewFlowLayoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var collectionViewCompositionalLayoutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Collection View (Compositional-Layout)", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapCollectionViewCompositionalLayoutButton), for: .touchUpInside)
        return button
    }()
    
    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }


}

extension MainViewController {
    
    private func setupUI() -> Void {
        
        view.backgroundColor = .systemBackground
        
        [tableViewButton, collectionViewFlowLayoutButton, collectionViewCompositionalLayoutButton].forEach { vStack.addArrangedSubview($0) }
        view.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            tableViewButton.heightAnchor.constraint(equalToConstant: 70),
            
            vStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
        ])
    }
    
    @objc func didTapTableViewButton() -> Void {
        self.delegate?.goToMyTableView()
    }
    
    @objc func didTapCollectionViewFlowLayoutButton() -> Void {
        self.delegate?.goToMyCollectionViewFlowLayout()
    }
    
    @objc func didTapCollectionViewCompositionalLayoutButton() {
        self.delegate?.goToMyCollectionViewCompositionalLayout()
    }
}

#if DEBUG
import SwiftUI

#Preview(body: {
    MainViewController()
})
#endif
