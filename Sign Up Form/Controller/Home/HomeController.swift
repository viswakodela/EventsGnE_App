//
//  HomeController.swift
//  Sign Up Form
//
//  Created by Viswa Kodela on 3/25/19.
//  Copyright © 2019 Viswa Kodela. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class HomeController: UICollectionViewController {
    
    private let homeCellID = "homeCellID"
    var locationManager: CLLocationManager = CLLocationManager()
    var events = [Event]()
    var lattitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    var searchText = ""
    var isPaginating = false
    var currentPage: Int = 1
    var timer: Timer?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setSearchBarController()
        checkPermission()
        if let lattitude = self.lattitude, let longitude = self.longitude {
            fetchData(lattitude: lattitude, logitude: longitude, searchText: searchText, page: self.currentPage)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarView?.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
        searchController.searchBar.backgroundColor = .white
    }
    
    let activityIndicator: UIActivityIndicatorView = {
        let av = UIActivityIndicatorView(style: .gray)
        av.translatesAutoresizingMaskIntoConstraints = false
        av.startAnimating()
        av.hidesWhenStopped = true
        return av
    }()
    
    fileprivate func setupLayout() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: homeCellID)
        
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    fileprivate func setSearchBarController() {
        
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        collectionView.keyboardDismissMode = .onDrag
        collectionView.alwaysBounceVertical = true
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
    }
    
    func checkPermission() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            checkLocationAuthorization()
        } else {
            print("Show an alert saying user location is turned - off")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            getUserLocation()
            break
        case .authorizedWhenInUse:
            getUserLocation()
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            //TODO:- Show alert
            break
        case .restricted:
            break
        }
    }
    
    func getUserLocation() {
        
        if let location = locationManager.location?.coordinate {
            print(location.latitude, location.longitude)
            
            self.lattitude = location.latitude
            self.longitude = location.longitude
        }
    }
    
    func fetchData(lattitude: CLLocationDegrees, logitude: CLLocationDegrees, searchText: String?, page: Int?) {
        print("Fetching curretnt page: \(currentPage)")
        APIService.shared.fetchHomeFeedData(lattitude: lattitude, longitude: logitude, searchText: searchText, page: page) { [weak self] (events, err) in
            
            self?.activityIndicator.stopAnimating()
            
            if let error = err {
                //TODO:- Show an Alert
                print(error.localizedDescription)
                return
            }
            
            guard let events = events else {return}
            self?.events = events
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK:-  CollectionView Delegate and DataSource methods
extension HomeController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(events.count)
        return events.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homeCellID, for: indexPath) as! HomeCell
        let event = events[indexPath.item]
        
        cell.event = event
        
        if indexPath.item == events.count - 1 && !isPaginating {
            print("Fetch more data")
            
            self.currentPage += 1
            if let lattitude = self.lattitude, let longitude = self.longitude {
                
                APIService.shared.fetchHomeFeedData(lattitude: lattitude, longitude: longitude, searchText: searchText, page: self.currentPage) { [weak self] (events, err) in
                    
                    if let error = err {
                        //TODO:- Show an Alert
                        print(error.localizedDescription)
                        return
                    }
                    
                    guard let events = events else {return}
                    self?.events += events
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    
                    if events.count < 6 {
                        //This is to stop dowloading the last remaining Events
                        self?.isPaginating = true
                    } else {
                        self?.isPaginating = false
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftRightPadding = view.frame.width * 0.03
        let interItemSpacing = view.frame.width * 0.03
        let width = (view.frame.width - 2 * leftRightPadding - interItemSpacing) / 2
        return CGSize(width: width, height: width + 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let minLineSpacing = view.frame.width * 0.03
        return minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftRightPadding = view.frame.width * 0.03
        return UIEdgeInsets(top: 10, left: leftRightPadding, bottom: 10, right: leftRightPadding)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let postDetails = PostDetailsController()
        let event = events[indexPath.item]
        postDetails.event = event
        navigationController?.pushViewController(postDetails, animated: true)
    }
}


//MARK:- SearchBar Delegate
extension HomeController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { [weak self] (_) in
            
            if let lattitide = self?.lattitude, let longitude = self?.longitude {
                
                self?.events.removeAll()
                self?.isPaginating = false
                self?.searchText = searchText
                self?.currentPage = 1
                
                APIService.shared.fetchHomeFeedData(lattitude: lattitide, longitude: longitude, searchText: searchText, page: self?.currentPage) { [weak self] (events, err) in
                    
                    if let error = err {
                        //TODO:- Show an Alert
                        print(error.localizedDescription)
                        return
                    }
                    
                    
                    guard let events = events else {return}
                    self?.events += events
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    
                    if events.count < 6 {
                        //This is to stop dowloading the last remaining Events
                        self?.isPaginating = true
                    } else {
                        self?.isPaginating = false
                    }
                }
            }
        })
    }
    
    //When Cancel button is tapped we are doing the same thing as when search bar is Empty
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { [weak self] (_) in
            
            if let lattitide = self?.lattitude, let longitude = self?.longitude {
                
                self?.events.removeAll()
                self?.isPaginating = false
                self?.searchText = ""
                self?.currentPage = 1
                
                APIService.shared.fetchHomeFeedData(lattitude: lattitide, longitude: longitude, searchText: "", page: self?.currentPage) { [weak self] (events, err) in
                    
                    if let error = err {
                        //TODO:- Show an Alert
                        print(error.localizedDescription)
                        return
                    }
                    
                    
                    guard let events = events else {return}
                    self?.events += events
                    
                    DispatchQueue.main.async {
                        self?.collectionView.reloadData()
                    }
                    
                    if events.count < 6 {
                        //This is to stop dowloading the last remaining Events
                        self?.isPaginating = true
                    } else {
                        self?.isPaginating = false
                    }
                }
            }
        })
    }
}

extension HomeController: UISearchControllerDelegate {
    
    func willPresentSearchController(_ searchController: UISearchController) {
        print("presenting search Controller")
    }
}


//MARK:- Location manager Delegate
extension HomeController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
