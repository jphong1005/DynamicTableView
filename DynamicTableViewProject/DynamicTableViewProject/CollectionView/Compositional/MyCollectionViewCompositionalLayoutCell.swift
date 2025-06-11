//
//  CollectionViewCell.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/11/25.
//

import UIKit

class MyCollectionViewCompositionalLayoutCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyCollectionViewCompositionalLayoutCell"
    
    lazy var myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //  imageView.image = UIImage(systemName: "photo.fill")
        imageView.image = UIColor.makeRandomColourImage()
        imageView.image?.withTintColor(UIColor.systemGray6,
                                       renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "some Label"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.textColor = .label
        return label
    }()
    
    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.alignment = .fill
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

extension MyCollectionViewCompositionalLayoutCell {
    
    private func setupUI() {
        
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
