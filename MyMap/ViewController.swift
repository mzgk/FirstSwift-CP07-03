//
//  ViewController.swift
//  MyMap
//
//  Created by 水垣岳志 on 2018/01/29.
//  Copyright © 2018年 mzgkworks.com. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - アウトレット
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - プロパティー
    let manager = CLLocationManager()

    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // ユーザーの許可操作を取得するため（CLLocationManagerDelegate用）
        manager.delegate = self

        // 現在の許可状況を取得　→　When In Use以外なら、When In Useの許可を求める
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            // 許可リクエスト（ダイアログを表示）
            manager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - CLLocationManagerDelegate
    // 許可ステータスが更新された時に呼び出される
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

    }
}

