//
//  CollectionViewController.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/11/25.
//

import UIKit

protocol MyCollectionViewCompositionalLayoutViewControllerDelegate: AnyObject {
    func willDisappear() -> Void
}

class MyCollectionViewCompositionalLayoutViewController: UIViewController {

    var delegate: MyCollectionViewCompositionalLayoutViewControllerDelegate?
    
    lazy var mySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            UIImage(systemName: "list.bullet")!,
            UIImage(systemName: "square.grid.2x2.fill")!,
            UIImage(systemName: "square.grid.3x3.fill")!,
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(handleValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    lazy var myCollectionViewCompositionalLayout: UICollectionView = {
        var layout: UICollectionViewCompositionalLayout = createCompositionalLayout(index: mySegmentedControl.selectedSegmentIndex) as! UICollectionViewCompositionalLayout
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCompositionalLayoutCell.self, forCellWithReuseIdentifier: MyCollectionViewCompositionalLayoutCell.reuseIdentifier)
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

extension MyCollectionViewCompositionalLayoutViewController {
    
    private func setupUI() -> Void {
        
        myCollectionViewCompositionalLayout.dataSource = self
        
        view.backgroundColor = .systemBackground
        [mySegmentedControl, myCollectionViewCompositionalLayout].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            mySegmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mySegmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mySegmentedControl.bottomAnchor.constraint(equalTo: myCollectionViewCompositionalLayout.topAnchor, constant: -20),
            mySegmentedControl.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            myCollectionViewCompositionalLayout.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            myCollectionViewCompositionalLayout.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            myCollectionViewCompositionalLayout.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func handleValueChanged(_ sender: UISegmentedControl) {
        myCollectionViewCompositionalLayout.setCollectionViewLayout(createCompositionalLayout(index: mySegmentedControl.selectedSegmentIndex), animated: true)
        
        //  3x3 -> 2x2로 되돌아갈 때, 스크롤이 되어지는 현상 방지
        myCollectionViewCompositionalLayout.setContentOffset(.zero, animated: true)
    }


}

extension MyCollectionViewCompositionalLayoutViewController {
    private func createCompositionalLayout(index: Int) -> UICollectionViewLayout {
        switch index {
        case 0:
            let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
                //  absolute: 고정값
                //  estimated: 추측값
                //  fraction: 퍼센트값
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                //  let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.elementKind)
                
                //  section.decorationItems = [backgroundItem]
                
                return section
            }
            //  layout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.elementKind)
            return layout
            
        case 1:
            let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/2))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                //  let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.elementKind)
                
                //  section.decorationItems = [backgroundItem]
                
                return section
            }
            //  layout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.elementKind)
            
            return layout
            
        case 2:
            let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1/3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
                
                //  let backgroundItem = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.elementKind)
                
                //  section.decorationItems = [backgroundItem]
                
                return section
            }
            //  layout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.elementKind)
            
            return layout
            
        default: return UICollectionViewLayout()
        }
    }
}

extension MyCollectionViewCompositionalLayoutViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCompositionalLayoutCell.reuseIdentifier, for: indexPath) as! MyCollectionViewCompositionalLayoutCell
        cell.configure(text: "\(indexPath.row)")
        
        return cell
    }
}

#if DEBUG
import SwiftUI

#Preview(body: {
    MyCollectionViewCompositionalLayoutViewController()
})
#endif

