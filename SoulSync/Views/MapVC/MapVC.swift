import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkLocationAuthorization()
    }

    func checkLocationAuthorization() {
        let authorizationStatus = locationManager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
            // No need to call addCustomMarkers() here, as it's called when the location is updated
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            // Show an alert or prompt the user to enable location services
            showLocationDisabledAlert()
        case .restricted:
            // Location services are restricted, user cannot grant permission
            break
        @unknown default:
            fatalError("New case for CLLocationManager.authorizationStatus was added")
        }
    }

    func showLocationDisabledAlert() {
        let alert = UIAlertController(title: "Location Access Denied", message: "Please enable location services in Settings to use this feature.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsUrl)
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func addCustomMarkers() {
        // Add custom markers for demonstration
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
        marker1.title = "Marker 1"
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: mapView.camera.target.latitude, longitude: mapView.camera.target.longitude)
        marker2.title = "Marker 2"
        marker2.map = mapView
    }
}

extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
        mapView.camera = camera
        locationManager.stopUpdatingLocation()
        
        // Add custom markers once location is updated
        addCustomMarkers()
    }
}
