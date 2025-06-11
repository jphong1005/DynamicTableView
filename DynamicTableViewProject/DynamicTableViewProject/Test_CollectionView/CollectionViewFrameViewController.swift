//
//  TestViewController.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/3/25.
//

import UIKit

//  UICollectionViewCell의 크기를 조절하는 방법 3가지
//  1. UICollectionViewDelegateFlowLayout의 sizeForItemAt 계산
//      - 가장 보편적이며 유연한 방식
//      - 장점: 상황에 따라 크기 계산 가능 (다른 열 수, spacing 등 적용 쉬움)
//      - 단점: 반드시 delegate 채택 필요

//  2. UICollectionViewFlowLayout의 itemSize 설정
//      - Frame 기반인 정적 레이아웃에 유용
//      - 장점: 간단하고 설정이 빠름
//      - 단점: 동적 크기의 cell 설정 불가

//  3. UICollectionViewCompositionalLayout 사용 (iOS 13+)
//      - NSCollectionLayoutItem의 fractionalWidth, fractionalHeight 설정
//      - 장점: 직관적으로 구성 가능
//      - 단점: iOS 13+부터 사용 가능, 코드 복잡

class CustomCollectionViewCellFrame: UICollectionViewCell {
    
    static let reuseIdentifier = "CustomCollectionViewCellFrame"
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        //  imageView.image = UIImage(systemName: "photo")
        imageView.image = UIColor.makeRandomColourImage()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemYellow
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Frame-based"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .systemBlue
        return label
    }()
    
    //  뷰가 최초로 생성될 때 호출됨
    //  서브뷰를 추가하거나, 기본 속성 설정하는 데 사용
    //  이 시점에서는 뷰의 정확한 frame이 정해지지 않았을 수 있음
    //  따라서 위치나 크기를 설정하는 데에는 부적절함
    override init(frame: CGRect) {
        super.init(frame: frame)
        //  뷰 계층 구성만 처리
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
        
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        
        [myImageView, myLabel].forEach { contentView.addSubview($0) }
    }
    
    //  (Frame 기반 서브 뷰의 레이아웃을 직접 다룰 때 사용)
    //  뷰의 frame이 정확히 정해진 뒤 호출됨
    //  실제 UI 요소의 위치와 크기를 계산하고 설정하는 데 적합함
    //  뷰의 크기가 바뀔 때(e.g. 디바이스 회전, 동적 셀 크기 조절 등) 여러 번 호출될 수 있음
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //  뷰의 실제 사이즈를 알고 난 후에 레이아웃을 정확히 잡음
        
        //  contentView.frame.size의 기본값 = (50.0, 50.0)
        //  이 cell 자체의 size를 조절하려면, cell의 외부에서 조절해야함
        //  (UITableViewCell의 크기를 조절하는 것도 UITableViewDelegate의 heightForRowAt을 사용하는 것처럼!)
        
        //  myImageView.frame.size = 16Pro: (120.0, 80.0)
        //  myImageView.frame.size = 16e:   (116.0, 75.0)
        myImageView.frame = CGRect(x: 5,
                                   y: 0,
                                   width: (contentView.frame.size.width) - 10,
                                   height: (contentView.frame.size.height) - 50)
        
        //  myLabel.frame.size = (120.0, 50.0)
        myLabel.frame = CGRect(x: 5,
                               y: (contentView.frame.size.height) - 50,
                               width: (contentView.frame.size.width) - 10,
                               height: 50)
    }
     
    
    //  cell 객체가 재사용되기 전에 호출되어, 이전에 cell에 설정된 데이터나 상태를 초기화
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    func configure(text label: String) -> Void {
        myLabel.text = label
    }
}

class CollectionViewFrameViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() -> Void {
        
        view.backgroundColor = .systemBackground
        
        layout.scrollDirection = .vertical
        
        //  외부에서 cell의 size를 조절하는 방법 2.
        //  각 행(또는 열) 사이의 최소 간격
        /// 수직 스크롤일 때: 각 행 사이 간격
        /// 수평 스크롤일 때: 각 열 사이 간격
        //  layout.minimumLineSpacing = 10
        
        //  같은 행(또는 열) 내 아이템들 간의 최소 간격
        /// 수직 스크롤일 때: 한 행 내에서 아이템들 간의 가로 간격
        /// 수평 스크롤일 때: 한 열 내에서 아이템들 간의 세로 간격
        //  layout.minimumInteritemSpacing = 1
        
        //  let width = (view.frame.size.width / 3) - 4
        //  let height = trunc((view.frame.size.height / 6.5) - 4)
        //  layout.itemSize = CGSize(width: width, height: height)
        
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(CustomCollectionViewCellFrame.self,
                                forCellWithReuseIdentifier: CustomCollectionViewCellFrame.reuseIdentifier)
        collectionView.frame = view.bounds
        
        view.addSubview(collectionView)
    }


}

// MARK: - UICollectionViewDataSource
extension CollectionViewFrameViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCellFrame.reuseIdentifier, for: indexPath) as! CustomCollectionViewCellFrame
        cell.configure(text: "\(indexPath.row)")
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
//  외부에서 cell의 size를 조절하는 방법 1.
extension CollectionViewFrameViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 1
        
        let width = (view.frame.size.width / 3) - 4             //  width: 130.0
        let height = trunc((view.frame.size.height / 6.5) - 4)  //  height: 130.0
        
        return CGSize(width: width, height: height)
    }
}

#if DEBUG
import SwiftUI

#Preview(body: {
    CollectionViewFrameViewController()
})
#endif
