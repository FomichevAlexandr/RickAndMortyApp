//
//  MainScreenAssembly.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 14.06.2021.
//


import UIKit

final class MainScreenAssembly
{
    static func build() -> UIViewController {
        let tabBarController = UITabBarController()
        let storage = CoreDataStorage()
        let characterVC = CharacterScreenAssembly.build(storage: storage)
        let locationVC = LocationScreenAssembly.build(storage: storage)
        tabBarController.setViewControllers([characterVC, locationVC], animated: true)
        locationVC.tabBarItem.image = UIImage(systemName: "location.fill")
        characterVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        return tabBarController
    }
}
