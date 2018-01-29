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
//        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
//            // 許可リクエスト（ダイアログを表示）
//            manager.requestWhenInUseAuthorization()
//        }

        // 正確には、requestWhenInUseAuthorization()は.notDetermined（１回も操作してない）時にしかコールされないので
        // 上記のコードは以下のように変更
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // 許可リクエスト（ダイアログが表示される）
            print("初回")
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            print("許可済み")
            break
        case .restricted, .denied:
            print("自分で許可してのダイアログを表示させる")
            // 設定　→　プライバシー　→　位置情報サービス　→　アプリ名
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - CLLocationManagerDelegate
    // 許可ステータスが更新された時に呼び出される
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("ステータス更新")
        print(CLLocationManager.authorizationStatus().rawValue)
        if status == .authorizedWhenInUse {
            // 現在地の取得を実行（１回）
            manager.requestLocation()
        }
    }

    // 現在地が更新されたときに呼び出される
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations : \(locations)")

        // 現在地の情報を取得
//        let current = locations[0]
        // 最新情報は配列の末尾（lastプロパティの型：CLLocation?でOptionalで定義されている→currentはOptional→nilなら早期リターン）
        guard let current = locations.last else {
            return
        }
        // MapViewに表示するための情報を作成（現在地を中心にして、緯度経度の表示範囲は500m）
        let region = MKCoordinateRegionMakeWithDistance(current.coordinate, 500, 500)
        // MapViewに表示
        mapView.setRegion(region, animated: true)

        // ピンを表示する
        let annotation = MKPointAnnotation()
        annotation.coordinate = current.coordinate
        mapView.addAnnotation(annotation)
    }

    // 位置情報の取得に失敗した場合
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error : \(error)")
    }
}

