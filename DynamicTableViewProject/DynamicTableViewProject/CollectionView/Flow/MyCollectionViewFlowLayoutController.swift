//
//  MyCollectionViewController.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/2/25.
//

import UIKit

protocol MyCollectionViewFlowLayoutViewControllerDelegate: AnyObject {
    func willDisappear() -> Void
}

class MyCollectionViewFlowLayoutViewController: UIViewController {

    var delegate: MyCollectionViewFlowLayoutViewControllerDelegate?
    
    lazy var myCollectionViewFlowLayout: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //  layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewFlowLayoutCell.self,
                                forCellWithReuseIdentifier: MyCollectionViewFlowLayoutCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.delegate?.willDisappear()
    }
    
    deinit {
        print("- \(type(of: self)) deinit")
    }


}

extension MyCollectionViewFlowLayoutViewController {
    
    private func setupUI() -> Void {
        
        myCollectionViewFlowLayout.dataSource = self
        myCollectionViewFlowLayout.delegate = self
        
        view.backgroundColor = .systemBackground
        view.addSubview(myCollectionViewFlowLayout)
        
        NSLayoutConstraint.activate([
            myCollectionViewFlowLayout.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myCollectionViewFlowLayout.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myCollectionViewFlowLayout.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            myCollectionViewFlowLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension MyCollectionViewFlowLayoutViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewFlowLayoutCell.reuseIdentifier, for: indexPath) as! MyCollectionViewFlowLayoutCell
        cell.configure(text: "\(indexPath.row)")
        
        return cell
    }
}

extension MyCollectionViewFlowLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 130)
    }
}

#if DEBUG
import SwiftUI

#Preview(body: {
    MyCollectionViewFlowLayoutViewController()
})
#endif
