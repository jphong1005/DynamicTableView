//
//  MyTableViewCell.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 5/30/25.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "MyTableViewCell"
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    lazy var userNickname: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User Nickname"
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var userID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@userID"
        label.textColor = .systemGray
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem Ipsum es simplemente el texto de relleno de las imprentas y archivos de texto. Lorem Ipsum ha sido el texto de relleno estándar de las industrias desde el año 1500, cuando un impresor (N. del T. persona que se dedica a la imprenta) desconocido usó una galería de textos y los mezcló de tal manera que logró hacer un libro de textos especimen. No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original. Fue popularizado en los 60s con la creación de las hojas \"Letraset\", las cuales contenian pasajes de Lorem Ipsum, y más recientemente con software de autoedición, como por ejemplo Aldus PageMaker, el cual incluye versiones de Lorem Ipsum."
        label.textColor = .label
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.contentMode = .scaleToFill
        stackView.tintColor = .systemGray
        return stackView
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal)
        button.contentMode = .scaleToFill
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() -> Void {
        
        contentView.backgroundColor = .systemBackground
        
        [userNickname, userID].forEach { vStack.addArrangedSubview($0) }
        [heartButton, likeButton, shareButton].forEach { hStack.addArrangedSubview($0) }
        
        [profileImage, vStack, contentLabel, hStack].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 50),
            profileImage.heightAnchor.constraint(equalToConstant: 50),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            
            vStack.heightAnchor.constraint(equalTo: profileImage.heightAnchor),
            vStack.topAnchor.constraint(equalTo: profileImage.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 8),
            
            contentLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 8),
            contentLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            contentLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8),
            //  First Item: contentLabel.trailingAnchor (contentLabel.Trailing)
            //  Relation: Less Than or Equal
            //  Second Item: contentView.trailingAnchor (Superview.Trailing)
            
            //  contentView.trailingAnchor.constraint(greaterThanOrEqualTo: contentLabel.trailingAnchor, constant: 8)
            //  First Item: contentView.trailingAnchor (Superview.Trailing)
            //  Relation: Greater Than or Equal
            //  Second Item: contentLabel.trailingAnchor (contentLabel.Trailing)
            
            heartButton.widthAnchor.constraint(equalToConstant: 20),
            heartButton.heightAnchor.constraint(equalToConstant: 20),
            likeButton.widthAnchor.constraint(equalToConstant: 20),
            likeButton.heightAnchor.constraint(equalToConstant: 20),
            shareButton.widthAnchor.constraint(equalToConstant: 20),
            shareButton.heightAnchor.constraint(equalToConstant: 20),
            
            hStack.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
            hStack.leadingAnchor.constraint(equalTo: contentLabel.leadingAnchor),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

}
