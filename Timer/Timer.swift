//
//  Timer.swift
//  Timer
//
//  Created by Notty on 2020/11/25.
//

import SwiftUI
struct TimerView : View {
    //現在時間表示の変数を定義 内容が書き換わったタイミングでテキストを変更したいのでStateをつける
    @State var timeString = ""

    var body: some View {
        Text(timeString) //現在時間を表示するテキスト
            .onAppear(perform: { //テキストが画面に表示するタイミングをキャッチ
                fire() //画面が表示されたらfireという関数を呼び出す
            })
    }

//** タイマーを動かす関数 */

    private func fire () {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                let now = Date()
                updateTimeString(date: now)

            }
        }

    private func updateTimeString(date: Date) {
        let df: DateFormatter = DateFormatter()
        df.dateFormat = "h:mm"
        timeString = df.string(from: date)

    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
    TimerView()
    }
}
