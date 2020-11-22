//
//  ContentView.swift
//  Timer
//
//  Created by Notty on 2020/11/18.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 60 //時間//
let lineWith: CGFloat = 20 //円の太さ//
let radius: CGFloat = 130 //円のサイズ//

struct ContentView: View {
    @State private var isActive = false  //真ん中の数字//
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    @State private var textField = ""
    @State var timeString = ""
    @State var isShown = false
    
    let timer = Timer.publish(every: 1, on: .main , in: .common).autoconnect()
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .opacity(0.05)
                .edgesIgnoringSafeArea(.all)
            VStack(){
                ZStack{
                    Circle()
                        .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                        .stroke(timeRemaining > 6 ? Color.blue : timeRemaining > 3 ? Color.yellow : Color.red , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut)
                    
                    Text("\(Int(timeRemaining))")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .foregroundColor(Color.black .opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .padding(.all)
                }.frame(width: radius * 2.5, height: radius * 2.5)
                
                VStack(){
                    Text("Memo")
                        .font(.system(size: 30, weight: .bold, design: .rounded ))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("NextActionaaa", text: $textField )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 40, weight: .bold, design: .default ))
                        .padding(.horizontal, 24)
                    
                    Button(action: {
                        print("Rounded Button")
                    }, label: {
                        Text("Start!")
                            .padding(16)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(24)
                    })
                }
                
                HStack(){
                    
                    Label("\(isActive ? "Stop" : "Play")", systemImage: "\(isActive ? "Pause.fill" : "play.fill")")
                        .foregroundColor(isActive ? .red : .yellow).font(.title).onTapGesture(perform: {
                            isActive.toggle()
                        })
                    
                    
                    //リセットの処理
                    Label("Reset", systemImage: "stop.fill")
                        .foregroundColor(.red)
                        .onTapGesture(perform: {
                            isActive = false
                            timeRemaining = defaultTimeRemaining
                        })
                    
                }.onReceive(timer, perform: { _ in guard isActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        isActive = false
                        timeRemaining = defaultTimeRemaining
                    }
                })
                //リセットの処理はここまで.この処理をボタンに移植したい
            }
            
            VStack(spacing: 0) {
                
                Spacer()
                Spacer()
                Rectangle()
                    .frame(height: 0.25, alignment: .top)
                    .foregroundColor(Color.gray)
                Color.white
                    .edgesIgnoringSafeArea(.top)
                    .frame(height:0)
                TabView()
                
                
                
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//▼道筋(仮)
//- 60秒のカウントダウンを3時間に変更
//- カウントダウンのカラーを30分以下で赤色
//- テキスト入力後Startボタンをタップするとカウントダウン開始
//- ResumeをDeleatボタンに変更。タップするとデリートダイアログが表示され(テキスト削除とカウントリセット)
