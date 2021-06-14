//
//  LocationScreenViewController.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit

class LocationScreenViewController: UIViewController {
    
    private let presenter: ILocationScreenPresenter
    private let tableAdapter: ILocationScreenTableAdapter
    private let customView: LocationScreenView
    
    init(presenter: ILocationScreenPresenter, tableAdapter: ILocationScreenTableAdapter) {
        self.presenter = presenter
        self.tableAdapter = tableAdapter
        self.customView = LocationScreenView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.customView
        self.tableAdapter.tableView = self.customView.tableView
        self.tableAdapter.presenter = self.presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidload(view: self.customView, tableAdapter: self.tableAdapter)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
