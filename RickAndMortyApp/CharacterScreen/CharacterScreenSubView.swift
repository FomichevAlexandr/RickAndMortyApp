//
//  CharacterScreenView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import UIKit

final class CharacterScreenSubView : UIView
{
    private let descriptionLabel: UILabel
    private let imageView: UIImageView
    private let imageHeight = 300
    private let fontSize: CGFloat = 18
    private let cornerRadius: CGFloat = 14
    
    override init(frame: CGRect = CGRect.zero) {
        self.descriptionLabel = UILabel()
        self.imageView = UIImageView()
        super.init(frame: frame)
        self.addSubViews()
        self.configurateViews()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(vm: CharacterScreenViewModel) {
        self.descriptionLabel.text = "\(vm.name)\n\(vm.species)"
        self.imageView.image = vm.image
    }
    
    private func addSubViews() {
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
    }
    
    private func configurateViews() {
        self.descriptionLabel.font = UIFont.boldSystemFont(ofSize: self.fontSize)
        self.descriptionLabel.adjustsFontSizeToFitWidth = true
        self.descriptionLabel.numberOfLines = 2
        self.imageView.layer.cornerRadius = self.cornerRadius
        self.imageView.layer.masksToBounds = true
    }
    
    private func makeConstraints() {
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        self.imageView.snp.makeConstraints{ make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(Offsets.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(imageHeight)
            make.bottom.equalToSuperview()
        }
    }
}
