//
//  LocationScreenTableAdapter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import UIKit

protocol ILocationScreenTableAdapter: AnyObject
{
    var presenter: ILocationScreenPresenter? { get set}
    var tableView: UITableView? { get set}
    func update(locations: [LocationScreenViewModel])
}

class LocationScreenTableAdapter: NSObject
{
    private var locations = [LocationScreenViewModel]()
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
    func update(locations: [LocationScreenViewModel]) {
        self.locations = locations
        self.tableView?.reloadData()
    }
}

extension LocationScreenTableAdapter: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Click")
    }
}

extension LocationScreenTableAdapter: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = location.name
        content.secondaryText = location.type
        cell.backgroundColor = .mainBackgroundColor
        cell.contentConfiguration = content
        return cell
    }
    
    
}
