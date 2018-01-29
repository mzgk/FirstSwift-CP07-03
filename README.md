# 「iPhoneアプリ開発講座　はじめてのSwift」

## CHAPTER07-03　マップ

### 改造点
- 現在地にピンを表示
- 現在地情報の配列から、現在地を取得する要素位置を末尾に変更
- ユーザー許可部分の詳細化

### 不明点
- ユーザー許可周り
    - 一度許可　→　設定から不許可　→　再度許可させる方法

### 確認結果 Xcode9.2 Swift4 iOS11.2.2
- requestWhenInUseAuthorization()は.notDetermined（１回も操作してない）時にしかコールされない
- switch caseで、.notDeterminedの場合はCallさせる
- .authorizedAlways, .authorizedWhenInUseは許可済みなので何もしない
- .restricted, .deniedは、自前でアラート表示させてユーザー操作を促す
    - 設定　→　プライバシー　→　位置情報サービス　→　アプリ名
- 設定の操作後、ステータスが変更されたらlocationManager(_:didChangeAuthorization:)がコールされる
