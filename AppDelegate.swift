//
//  AppDelegate.swift
//  20230314-chaitanyagongati-NYCSchools
//
//  Created by chaitanya gongati on 3/14/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let navController = UINavigationController()
            coordinator = MainCoordinator(navigationController: navController)
            coordinator?.start()
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        return true
    }

    


}

