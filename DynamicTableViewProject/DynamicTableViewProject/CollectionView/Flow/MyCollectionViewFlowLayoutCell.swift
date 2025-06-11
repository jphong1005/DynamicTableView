//
//  MyCollectionViewCell.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/3/25.
//

import UIKit

class MyCollectionViewFlowLayoutCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyCollectionViewFlowLayoutCell"
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIColor.makeRandomColourImage()
        //  imageView.image = UIImage(systemName: "photo.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        return imageView
    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some Label"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = .label
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        return label
    }()
    
    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        /// `alignment`: `axis의 수직 방향을 기준`으로 내부 요소들을 어떻게 정렬할지
        stackView.alignment = .fill
        
        /// `distribution`: `axis의 수평 방향을 기준`으로 내부 요소들을 어떻게 배치할지
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
}

extension MyCollectionViewFlowLayoutCell {
    
    private func setupUI() {
        
        //  print(contentView.frame.size)
        contentView.backgroundColor = .systemBackground
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        
        [myImageView, myLabel].forEach { vStack.addArrangedSubview($0) }
        
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            vStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(text label: String) -> Void {
        myLabel.text = label
    }
}
