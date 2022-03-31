//
//  MapVC.swift
//  RemoteStateTask
//
//  Created by sunil biloniya on 30/03/22.
//

import UIKit
import GoogleMaps
class MapVC: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    var data: [ListData?] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
     }
    
    func setData(){
        for i in self.data {
            var locationMarker: GMSMarker!
            let latitude =  i?.lastWaypoint?.lat ?? 0.0
            let longitude = i?.lastWaypoint?.lng ?? 0.0
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self.mapView.camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoom: 8.80)
                locationMarker = GMSMarker(position: coordinate)
                locationMarker.map = self.mapView
            if i?.lastRunningState?.truckRunningState == 1 {
                locationMarker.icon = UIImage(named: "greenTruck")
            } else {
                locationMarker.icon = UIImage(named: "redTruck")
            }
            
            locationMarker.opacity = 0.75
        }
    }

    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }

}
