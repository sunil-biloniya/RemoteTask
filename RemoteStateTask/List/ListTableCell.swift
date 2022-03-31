//
//  ListTableCell.swift
//  RemoteStateTask
//
//  Created by sunil biloniya on 30/03/22.
//

import UIKit

class ListTableCell: UITableViewCell {
    
    
    // ignition(tru) = truck
    // ignition(false) = battery

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblVehicleNumber: UILabel!
    @IBOutlet weak var lblLastStopTime: UILabel!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblAgo: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblKmHr: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.shadowColor = UIColor.darkGray.cgColor
        self.bgView.layer.shadowOpacity = 0.2
        self.bgView.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.bgView.layer.masksToBounds = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(data: ListData?) {
        lblVehicleNumber.text = data?.truckNumber ?? ""
        if (data?.lastWaypoint?.speed ?? 0.0)>0.0 {
            lblSpeed.isHidden = false
            lblKmHr.isHidden = false
            lblSpeed.text = String(format: "%.2f", data?.lastWaypoint?.speed ?? 0.0)
        } else {
            lblSpeed.isHidden = true
            lblKmHr.isHidden = true
        }
        
        if data?.lastWaypoint?.ignitionOn == true {
            img.image = UIImage(named: "battery")
        } else {
            img.image = UIImage(named: "truck")
        }
        
        if data?.lastRunningState?.truckRunningState == 0 {
            
            let time = Double(data?.lastRunningState?.stopStartTime ?? 0)
            let date = Date(timeIntervalSince1970: ( time/1000.0))
            lblLastStopTime.text = "Stop since last \((date.timeAgo()))"
            
        } else {
            let time = Double(data?.lastRunningState?.stopStartTime ?? 0)
            let date = Date(timeIntervalSince1970: ( time/1000.0))
            lblLastStopTime.text = "Running since last \((date.timeAgo()))"
        }
        
        let time = Double(data?.lastWaypoint?.updateTime ?? 0)
        let date = Date(timeIntervalSince1970: ( time/1000.0))
        let all = date.timeAgo().split(separator: " ")
        lblDays.text = "\(all.first ?? "")"
        lblAgo.text = (date.timeAgo().replacingOccurrences(of: all.first!, with: "").trimmingCharacters(in: .whitespaces))
    }

}


