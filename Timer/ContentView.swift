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
    
    let timer = Timer.publish(every: 1, on: .main , in: .common).autoconnect()
    
    var body: some View {

        
    ZStack {
            Color.black
                .opacity(0.02)
                .edgesIgnoringSafeArea(.all)
    VStack(){
        ZStack{
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
            Circle()
                .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                .stroke(timeRemaining > 6 ? Color.blue : timeRemaining > 3 ? Color.yellow : Color.red , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut)
            
            Text("\(Int(timeRemaining))").font(.system(size: 60, weight: .bold, design: .rounded)).foregroundColor(Color.black .opacity(0.8
            )).multilineTextAlignment(.center).lineLimit(0).padding(.all)
                }.frame(width: radius * 2, height: radius * 2)
        
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
       
            Label("\(isActive ? "Stop" : "Play")", systemImage: "\(isActive ? "Pause.fill" : "play.fill")")
            .foregroundColor(isActive ? .red : .yellow).font(.title).onTapGesture(perform: {
                isActive.toggle()
            })
            Label("Resume", systemImage: "stop.fill")
                .foregroundColor(.red).font(.title).onTapGesture(perform: {
                isActive = false
                timeRemaining = defaultTimeRemaining
                })
            }
                }.onReceive(timer, perform: { _ in guard isActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        isActive = false
                        timeRemaining = defaultTimeRemaining
                    }
                })
            }
        }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        }
    }
}

//▼道筋(仮)

//- 60秒のカウントダウンを3時間に変更
//- カウントダウンのカラーを30分以下で赤色
//- テキスト入力後Startボタンをタップするとカウントダウン開始
//- カウントダウン中のStartボタンをDeleateに変更
//- ResumeをDeleatボタンに変更。タップするとデリートダイアログが表示され(テキスト削除とカウントリセット)
