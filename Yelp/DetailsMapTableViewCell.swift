//
//  DetailsMapTableViewCell.swift
//  Yelp
//
//  Created by Satyam Jaiswal on 2/20/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailsMapTableViewCell: UITableViewCell {

    @IBOutlet weak var businessMapView: MKMapView!
    
    var business: Business?{
        didSet{
            if let userLocation = BusinessesViewController.userCurrentLocation{
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(userLocation, span)
                self.businessMapView.setRegion(region, animated: false)
                
                if let latitude = business?.latitude{
                    if let longitude = business?.longitude{
                        print("plotting annotation")
                        let businessLocation = CLLocation(latitude: latitude, longitude: longitude)
                        
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = businessLocation.coordinate
                        annotation.title = business?.name
                        self.businessMapView.addAnnotation(annotation)
                    }
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
