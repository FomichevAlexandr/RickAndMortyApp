//
//  CharacterScreenScrollView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import UIKit
import SnapKit

final class CharacterScreenView: UIView
{
    private var characterSubViews: [CharacterScreenSubView]
    private var scrollView: UIScrollView
    private var innerView: UIView
    private var downloadButton: UIButton
    private var deleteButton: UIButton
    private var downloadButtonWasTapped: (() -> Void)?
    private var deleteButtonWasTapped: (() -> Void)?
    private let buttonHeight = 40
    private let activityIndicator: UIActivityIndicatorView
    
    override init(frame: CGRect = CGRect.zero) {
        self.characterSubViews = [CharacterScreenSubView]()
        self.scrollView = UIScrollView()
        self.innerView = UIView()
        self.downloadButton = UIButton()
        self.deleteButton = UIButton()
        self.activityIndicator = UIActivityIndicatorView(style: .medium)
        super.init(frame: frame)
        self.addSubviews()
        self.makeConstraints()
        self.configurateView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(self.scrollView)
        self.addSubview(self.downloadButton)
        self.addSubview(self.deleteButton)
    }
    
    private func configurateView() {
        self.backgroundColor = .mainBackgroundColor
        self.scrollView.backgroundColor = .mainBackgroundColor
        self.scrollView.addSubview(self.innerView)
        self.configurateButton(button: self.downloadButton, title: " Загрузить пресонажа ")
        self.configurateButton(button: self.deleteButton, title: " Удалить всех персонажей ")
        self.makeButtonConstraints()
        self.makeInnerViewConstraints()
        self.downloadButton.addTarget(self, action: #selector(self.downloadButtonAction), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(self.deleteButtonAction), for: .touchUpInside)
    }
    
    private func configurateButton(button: UIButton, title: String) {
        button.backgroundColor = .customPinkColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.layer.cornerRadius = 8
    }
    
    @objc
    private func downloadButtonAction() {
        self.downloadButtonWasTapped?()
        self.addActivityIndicator()
    }
    
    @objc
    private func deleteButtonAction() {
        self.deleteButtonWasTapped?()
        self.addActivityIndicator()
    }
    
    private func makeButtonConstraints() {
        self.downloadButton.snp.makeConstraints { make in
            make.height.equalTo(self.buttonHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.deleteButton.snp.top).offset(Offsets.bottom)
            make.left.equalToSuperview().offset(Offsets.left)
            make.right.equalToSuperview().offset(Offsets.right)
        }
        self.deleteButton.snp.makeConstraints { make in
            make.height.equalTo(self.buttonHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(Offsets.bottom)
            make.left.equalToSuperview().offset(Offsets.left)
            make.right.equalToSuperview().offset(Offsets.right)
        }
    }
    
    private func makeInnerViewConstraints(){
        self.innerView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(Offsets.left)
            make.right.equalTo(self).offset(Offsets.right)
            make.top.equalTo(self.scrollView).offset(Offsets.top)
            make.bottom.equalTo(self.scrollView).offset(Offsets.bottom)
        }
    }
    
    private func makeConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.downloadButton.snp.top).offset(Offsets.bottom)
        }
    }
    
    private func addActivityIndicator(){
        self.innerView.addSubview(self.activityIndicator)
        self.activityIndicator.color = .black
        if let lastView = characterSubViews.last{
            self.activityIndicator.snp.makeConstraints { make in
                make.top.equalTo(lastView.snp.bottom).offset(Offsets.top)
                make.centerX.equalToSuperview()
            }
        } else {
            self.activityIndicator.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(Offsets.top)
                make.centerX.equalToSuperview()
            }
        }
        self.activityIndicator.startAnimating()
    }
    
}

extension CharacterScreenView: ICharacterScreenView
{
    func completeDeleteButtonAction(buttonAction: @escaping (() -> Void)) {
        self.deleteButtonWasTapped = buttonAction
    }
    
    func completeDownloadButtonAction(buttonAction: @escaping (() -> Void)) {
        self.downloadButtonWasTapped = buttonAction
    }

    func update(vm: [CharacterScreenViewModel]) {
        self.characterSubViews = [CharacterScreenSubView]()
        for character in vm {
            let characterView = CharacterScreenSubView()
            characterView.update(vm: character)
            self.characterSubViews.append(characterView)
        }
        self.reloadScrollData()
    }
    
    private func reloadScrollData() {
        self.innerView.removeFromSuperview()
        self.innerView = UIView()
        self.scrollView.addSubview(self.innerView)
        self.makeInnerViewConstraints()
        self.makeInnerSubViewsConstarints()
    }
    
    private func makeInnerSubViewsConstarints() {
        var previous: CharacterScreenSubView?
        for index in 0..<self.characterSubViews.count {
            self.innerView.addSubview(self.characterSubViews[index])
            self.characterSubViews[index].snp.makeConstraints { make in
                if let previous = previous {
                    make.top.equalTo(previous.snp.bottom).offset(Offsets.top)
                } else {
                    make.top.equalToSuperview().offset(Offsets.top)
                }
                make.left.right.equalToSuperview()
            }
            if index == self.characterSubViews.count-1 {
                self.characterSubViews[index].snp.makeConstraints { make in
                    make.bottom.equalToSuperview().offset(Offsets.bottom)
                }
            } else {
                
            }
            previous = self.characterSubViews[index]
        }
    }
    
}
