//
//  CollectionReusableView.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 6/11/25.
//

import UIKit

class SectionBackgroundView: UICollectionReusableView {
    static let elementKind = "SectionBackgroundView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        layer.masksToBounds = true
    }
}
