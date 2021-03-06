//
//  LocationScreenTableAdapter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit

class LocationScreenTableAdapter: NSObject
{
    private var locations = [LocationModel]()
    private let cellIdentifier = "locationCell"
    weak var presenter: ILocationScreenPresenter?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
        }
    }
}

extension LocationScreenTableAdapter: ILocationScreenTableAdapter
{
    func update(locations: [LocationModel]) {
        self.locations = locations
        self.tableView?.reloadData()
    }
}

extension LocationScreenTableAdapter: UITableViewDelegate
{

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить", handler: {[weak self] (_, _, _) in
            if let id = self?.locations[indexPath.row].id {
                self?.presenter?.onItemDelete(locationID: id)
            }
        })
        deleteAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension LocationScreenTableAdapter: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = self.locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = location.name
        content.secondaryText = location.type
        cell.backgroundColor = .mainBackgroundColor
        cell.contentConfiguration = content
        return cell
    }
    
    
}
