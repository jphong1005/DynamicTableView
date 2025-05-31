//
//  MyTableViewCell.swift
//  DynamicTableViewProject
//
//  Created by 홍진표 on 5/30/25.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    static let reuseIdentifier: String = "MyTableViewCell"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    /// Cell이 렌더링 될 때 호출됨
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        print("MyTableViewCell awakeFromNub() called")
    }
    
    private func setupUI() -> Void {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }

}
