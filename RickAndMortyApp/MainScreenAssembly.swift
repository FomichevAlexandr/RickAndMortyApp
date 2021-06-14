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
        let characterVC = CharacterScreenAssembly.build()
        let locationVC = LocationScreenAssembly.build()
        tabBarController.setViewControllers([characterVC, locationVC], animated: true)
        return tabBarController
    }
}
