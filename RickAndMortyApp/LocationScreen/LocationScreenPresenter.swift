//
//  LocationScreenPresenter.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//

import Foundation
protocol ILocationScreenPresenter: AnyObject
{
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter)
}

final class LocationScreenPresenter
{
    private weak var tableAdapter: ILocationScreenTableAdapter?
    private var interactor: ILocationScreenInteractor
    private weak var locationView: ILocationScreenView?
    
    init(interactor: ILocationScreenInteractor) {
        self.interactor = interactor
    }
    
    private func update(vm: [LocationModel]) {
        DispatchQueue.main.async {
            self.tableAdapter?.update(locations: vm.map { LocationScreenViewModel(name: $0.name, type: $0.type) })
        }
    }
    
}

extension LocationScreenPresenter: ILocationScreenPresenter
{
    func viewDidload(view: ILocationScreenView, tableAdapter: ILocationScreenTableAdapter) {
        self.locationView = view
        self.locationView?.completeButtonAction { [weak self] in
            self?.interactor.getModelWithNewLocation(completion: { locations in
                self?.update(vm: locations)
            })
        }
        self.tableAdapter = tableAdapter
        self.update(vm: self.interactor.getModel())
    }
    
}
