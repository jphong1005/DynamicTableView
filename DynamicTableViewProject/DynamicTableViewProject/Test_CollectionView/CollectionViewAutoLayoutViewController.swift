//
//  CollectionViewAutoLayoutViewController.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/6/25.
//

import UIKit

class CustomCollectionViewCellAutoLayout: UICollectionViewCell {
    
    static let reuseIdentifier = "CustomCollectionViewCellAutoLayout"
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //  imageView.image = UIImage(systemName: "photo")
        //  SF Symbol은 vector 기반이고, 아이콘은 내부에서 원래 크기보다 작은 path 형태의 도형임 + contentMode를 같이 사용하면 도형이 전체 이미지영역을 꽉 채우지 않아 시각적인 여백이 생김
        //
        //  SF Symbols의 특징
        //  1. Vector 그래픽
        //  - 해상도에 독립적 → 확대/축소해도 깨지지 않음
        //
        //  2. Path 구조로 된 도형
        //  - 각 아이콘은 하나 이상의 Path로 이루어진 도형 묶음
        //  - Path는 내부적으로 크기, 위치, 두께 등을 기준으로 배치됨
        //  - 아이콘 자체가 "실제 그리는 내용"과 "아이콘 박스 크기"가 다를 수 있음 → 이게 여백처럼 보이게 함
        //
        //  3. PDF로 저장되어 있음
        
        imageView.image = UIColor.makeRandomColourImage()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemYellow
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AutoLayout-based"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .systemBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
        
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        
        [myImageView, myLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: myLabel.topAnchor),
            
            myLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            myLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            myLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            myLabel.heightAnchor.constraint(equalToConstant: 50),
        ])
         
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    func configure(text label: String) -> Void {
        myLabel.text = label
    }
}

class CollectionViewAutoLayoutViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCellAutoLayout.self, forCellWithReuseIdentifier: CustomCollectionViewCellAutoLayout.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() -> Void {
        
        view.backgroundColor = .systemBackground
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            /*
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             */
        ])
    }


}

extension CollectionViewAutoLayoutViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCellAutoLayout.reuseIdentifier, for: indexPath) as! CustomCollectionViewCellAutoLayout
        cell.configure(text: "\(indexPath.row)")
        
        return cell
    }
}

extension CollectionViewAutoLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.size.width / 3) - 4             //  width: 130.0
        let height = trunc((view.frame.size.height / 6.5) - 4)  //  height: 130.0
        
        return CGSize(width: width, height: height)
    }
}

#if DEBUG
import SwiftUI

#Preview(body: {
    CollectionViewAutoLayoutViewController()
})
#endif
