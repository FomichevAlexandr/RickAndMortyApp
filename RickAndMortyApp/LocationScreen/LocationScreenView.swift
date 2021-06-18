//
//  LocationScreenView.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit


final class LocationScreenView: UIView
{
    private(set) var tableView: UITableView
    private var downloadButton: UIButton
    private var buttonWasTapped: (() -> Void)?
    private let buttonHeight = 40
    
    override init(frame: CGRect = CGRect.zero) {
        self.tableView = UITableView()
        self.tableView.backgroundColor = .mainBackgroundColor
        self.downloadButton = UIButton()
        super.init(frame: frame)
        self.backgroundColor = .mainBackgroundColor
        self.addSubviews()
        self.makeConstraints()
        self.configurateButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        self.addSubview(self.tableView)
        self.addSubview(self.downloadButton)
    }
    
    private func makeConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.downloadButton.snp.top).offset(Offsets.bottom)
        }
        self.downloadButton.snp.makeConstraints { make in
            make.height.equalTo(self.buttonHeight)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(Offsets.bottom)
            make.left.equalToSuperview().offset(Offsets.left)
            make.right.equalToSuperview().offset(Offsets.right)
        }
    }
    
    private func configurateButton() {
        self.downloadButton.backgroundColor = .customPinkColor
        self.downloadButton.setTitle(" Загрузить локацию ", for: .normal)
        self.downloadButton.setTitleColor(.black, for: .normal)
        self.downloadButton.setTitleColor(.gray, for: .highlighted)
        self.downloadButton.layer.cornerRadius = 8
        self.downloadButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
    }
    
    @objc
    private func buttonAction() {
        self.buttonWasTapped?()
//        self.addActivityIndicator()
    }
    
}

extension LocationScreenView: ILocationScreenView
{
    func completeButtonAction(buttonAction: @escaping (() -> Void)) {
        self.buttonWasTapped = buttonAction
    }
}
