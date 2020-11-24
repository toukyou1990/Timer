//
//  ContentView.swift
//  Timer
//
//  Created by Notty on 2020/11/18.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 60 //時間//
let lineWith: CGFloat = 12 //円の太さ//
let radius: CGFloat = 100 //円のサイズ//

struct ContentView: View {
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    @State private var textField = ""
    @State var timeString = ""
    @State var isShown = false
    @State private var showingModal = false
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
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .padding(.all)
                }.frame(width: radius * 2.5, height: radius * 2.5)


                //ここからmemoとTextFieldの処理
                VStack(spacing: 0){
                    Text("Memo")
                        .font(.system(size: 24, weight: .bold, design: .rounded ))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("NextAction", text: $textField )
                        .padding(.top, 8.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(size: 32, weight: .bold, design: .rounded ))
                        .padding(.horizontal, 24)

                    //ここまでmemoとTextFieldの処理


                    //ここからStartbutton
                    Button(action: {
                        self.isActive.toggle()
                    })
                    {
                        Text("Start!")
                            .padding(16)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding([.top, .leading, .trailing], 24)
                    }
                }}
            //ここまでStartbutton

            //TabViewを下部に画面いっぱいに表示
            VStack(spacing: 0) {
                Spacer()
                Rectangle()
                    .frame(height: 0.25, alignment: .top)
                    .foregroundColor(Color.gray)
                Color.white
                    .edgesIgnoringSafeArea(.top)
                    .frame(height:0)
                HStack {

                    VStack(alignment: .leading) {
                        Button(action: {
                            self.showingModal.toggle()
                            }) {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .foregroundColor(.black)
                                    .frame(width: 24.0, height: 24.0, alignment: .leading)
                        }
                                    .sheet(isPresented: $showingModal) {
                                        WorkThroughView()

                            }
                    }
                            Spacer()

                            //RemoveButtonの表示。このボタンにResetの効果を与えたい
                            Button(action: {
                                self.isShown = true
                            }) {
                                Text("Remove")
                                    .foregroundColor(.red)
                            }.actionSheet(isPresented: $isShown, content: {
                                ActionSheet(
                                    title: Text("Remove the current task?"),
                                    message: Text("Deleting it allows you to enter a new task."),
                                    buttons: [
                                        .destructive(Text("Remove")){
                                            self.isActive = false
                                            timeRemaining = defaultTimeRemaining
                                            //ここにリセットの処理を書いていくのでググって対応する
                                        },
                                        .cancel()
                                    ]
                                )
                            })
                            //ここまでがRemoveButtonの処理

                        }
                        .padding()
                        .background(Color.white .edgesIgnoringSafeArea(.all))
                    }
                }
                //ここまでがTabView
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
