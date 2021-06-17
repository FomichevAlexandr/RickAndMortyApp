//
//  CharacterScreenViewController.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import UIKit

final class CharacterScreenViewController: UIViewController {

    private var presenter: ICharacterScreenPresenter
    private var customView: CharacterScreenView
    
    init (presenter: ICharacterScreenPresenter) {
        self.presenter = presenter
        self.customView = CharacterScreenView()
        super.init(nibName: nil, bundle: nil)
        self.title = "Персонажи"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = self.customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad(characterScreenView: self.customView)
    }

}
