//
//  ILocationScreenTableAdapter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//

import UIKit

protocol ILocationScreenTableAdapter: AnyObject
{
    var presenter: ILocationScreenPresenter? { get set}
    var tableView: UITableView? { get set}
    func update(locations: [LocationModel])
}
