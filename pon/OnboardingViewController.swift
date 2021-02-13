//
//  OnboardingViewController.swift
//  pon
//
//  Created by Demir Dazdarevic on 13.2.21..
//

import Foundation
import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    enum PageViews: String {
        case prva
        case druga
        case treca
        case login
    }
        
    fileprivate lazy var orderedViewController: [UIViewController] = {
        return [self.getViewController(withIdentifier: PageViews.prva.rawValue),
                self.getViewController(withIdentifier: PageViews.druga.rawValue),
                self.getViewController(withIdentifier: PageViews.treca.rawValue),
                self.getViewController(withIdentifier: PageViews.login
                                        .rawValue)]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return (storyboard?.instantiateViewController(withIdentifier: identifier))!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return orderedViewController.last }
        guard orderedViewController.count > previousIndex else { return nil }
        return orderedViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < orderedViewController.count else { return orderedViewController.first }
        guard orderedViewController.count > nextIndex else { return nil }
        return orderedViewController[nextIndex]
    }
    
    func presentationCount(for: UIPageViewController) -> Int {
        return orderedViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = orderedViewController.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        let proxy: UIPageControl = UIPageControl.appearance()
        if self.traitCollection.userInterfaceStyle == .dark {
                   // User Interface is Dark
               } else {
                proxy.pageIndicatorTintColor = UIColor.lightGray
                proxy.currentPageIndicatorTintColor = UIColor.black
                proxy.backgroundColor = UIColor.white
                   // User Interface is Light
               }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
