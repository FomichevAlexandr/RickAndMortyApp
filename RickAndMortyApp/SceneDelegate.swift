//
//  SceneDelegate.swift
//  RickAndMortyApp
//
//  Created by Александр Фомичев on 12.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = MainScreenAssembly.build()
        window.makeKeyAndVisible()
        self.window = window
        
    }


}

