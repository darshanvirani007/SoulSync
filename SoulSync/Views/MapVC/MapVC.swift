import UIKit
import GoogleMaps
import CoreLocation

class MapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    let apiKey = "AIzaSyDzuwTbmWJdslR2d00U9wlz7DhPA1S_ZAI"

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        // Initialize the map view without specifying a frame.
        mapView = GMSMapView()
        mapView.frame = view.bounds  // Set the frame after initialization.
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self

        // Set the initial camera position.
        let initialCamera = GMSCameraPosition.camera(withLatitude: 40.7128, longitude: -74.0060, zoom: 12)
        mapView.camera = initialCamera

        setMapStyle()

        view.addSubview(mapView)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            setMapStyle()
        }
    }

    @objc func setMapStyle() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let styleFileName = isDarkMode ? "map_dark_style" : "map_light_style"

        if let styleURL = Bundle.main.url(forResource: styleFileName, withExtension: "json") {
            do {
                let style = try String(contentsOf: styleURL)
                mapView.mapStyle = try GMSMapStyle(jsonString: style)
            } catch {
                print("Error loading map style: \(error.localizedDescription)")
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude, zoom: 12)
            mapView.animate(to: camera)
            fetchNearbyPlaces(coordinate: location.coordinate)
        }
    }

    private func fetchNearbyPlaces(coordinate: CLLocationCoordinate2D) {
        // Use a comma-separated list of types to filter the places
        let types = "restaurant,cafe,hospital,shopping_mall,pharmacy,supermarket"
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=1000&type=\(types)&key=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Error: \(error?.localizedDescription ?? "No data")")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any], let results = dictionary["results"] as? [[String: Any]] {
                    DispatchQueue.main.async {
                        self.updateMapWithPlaces(places: results)
                    }
                }
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

    private func updateMapWithPlaces(places: [[String: Any]]) {
        mapView.clear()  // Clear any existing markers

        for place in places {
            if let locationDict = place["geometry"] as? [String: Any],
               let location = locationDict["location"] as? [String: Any],
               let lat = location["lat"] as? Double,
               let lng = location["lng"] as? Double,
               let types = place["types"] as? [String] {
                print("Place Name: \(place["name"] ?? "") - Types: \(types)")

                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                marker.title = place["name"] as? String
                let iconName = iconForType(types: types)
                if let icon = UIImage(named: iconName) {
                    marker.icon = icon.resize(to: CGSize(width: 40, height: 40))
                } else {
                    print("Icon \(iconName) not found. Using default icon.")
                    marker.icon = UIImage(named: "default_icon")?.resize(to: CGSize(width: 40, height: 40))
                }
                marker.map = mapView
                print("Added marker for: \(place["name"] ?? "") with types: \(types) and icon: \(iconName)")
            }
        }
    }

    private func iconForType(types: [String]) -> String {
        let lowercasedTypes = types.map { $0.lowercased() }

        if lowercasedTypes.contains("restaurant") {
            return "pin_restaurant"
        } else if lowercasedTypes.contains("cafe") {
            return "pin_cafe"
        } else if lowercasedTypes.contains("hospital") {
            return "pin_hospital"
        } else if lowercasedTypes.contains("shopping_mall") || lowercasedTypes.contains("supermarket") {
            return "pin_mall"
        } else if lowercasedTypes.contains("pharmacy") {
            return "pin_medical"
        } else {
            return "default_icon"  // Default marker icon
        }
    }
}

extension UIImage {
    func resize(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
