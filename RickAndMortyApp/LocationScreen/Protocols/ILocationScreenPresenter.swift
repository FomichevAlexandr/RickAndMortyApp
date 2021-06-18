//
//  ILocationScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 18.06.2021.
//


protocol ILocationScreenPresenter: AnyObject
{
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter)
    func onItemDelete(locationID: Int)
}
