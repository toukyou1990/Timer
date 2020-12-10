//
//  ContentView.swift
//  Timer
//
//  Created by Notty on 2020/11/18.
//

import SwiftUI

let defaultTimeRemaining: CGFloat = 3600
let lineWith: CGFloat = 14
let radius: CGFloat = 90

struct ContentView: View {
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTimeRemaining
    @State private var textField = ""
    @State var timeString = ""
    @State var isShown = false
    @State private var showingModal = false

    let timer = Timer.publish(every: 1, on: .main , in: .common).autoconnect()

    var body: some View {

        ZStack() {
            Color
                .black
                .opacity(0.03)
                .edgesIgnoringSafeArea(.top)

            VStack(){
                //ここからサークルの表示と処理。
                ZStack{

                    Circle()//サークルのプログラミングを別で書く
                        .stroke(Color.blue.opacity(0.2), style: StrokeStyle(lineWidth: lineWith, lineCap: .round))

                    Circle()//サークルのプログラミングを別で書く
                        .trim(from: 0, to: 1 - ((defaultTimeRemaining - timeRemaining) / defaultTimeRemaining))
                        .stroke(timeRemaining > 6 ? Color.blue : timeRemaining > 3 ? Color.yellow : Color.red , style: StrokeStyle(lineWidth: lineWith, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut)


                    Text("\(Int(timeRemaining))")
                        .font(.system(size: 60, weight: .bold, design: .rounded))
                        .multilineTextAlignment(.center)
                        .lineLimit(0)
                        .padding(.all)
                }
                .frame(width: radius * 2.5, height: radius * 2.5)
                .padding(.top, 60.0)
                //ここまでサークルの表示と処理。処理をわける
                .onReceive(timer, perform: { _ in guard isActive else { return }
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    } else {
                        isActive = false
                        timeRemaining = defaultTimeRemaining

                    }
                })
                //ここからmemoとTextFieldの処理
                VStack(){
                    Text("Memo")
                        .font(.system(size: 24, weight: .bold, design: .rounded ))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    TextField("NextAction", text: $textField)
                        .padding(.vertical, 8.0)
                        .padding(.leading, 12.0)
                        .font(.system(size: 32, weight: .bold, design: .rounded ))
                        .background(Color("TextField"))
                        .cornerRadius(10)
                        .padding(.horizontal, 24)
                    //ここまでmemoとTextFieldの処理

                }




                //ここからStartbutton
                Button(action: {
                    //Startの処理を書く
                })
                {
                    Text("Start!")
                        .padding(16)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .onTapGesture(perform: {
                            isActive.toggle()
                            self.isActive = true
                        })

                }
                .padding(.horizontal, 24)
                .padding(.top,160.0)
                //ここまでStartbutton



                VStack(spacing: 0) {
                    Spacer()
                    Rectangle()
                        .frame(height: 0.5, alignment: .top)
                        .edgesIgnoringSafeArea(.top)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)


                    HStack {
                        VStack(alignment: .leading) {
                            Button(action: {
                                self.showingModal.toggle()
                            }) {
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .foregroundColor(Color("Icon"))
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
                                        self.textField = ""
                                    }, .cancel()
                                ]
                            )
                        })
                        //ここまでがRemoveButtonの処理

                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 60 ,alignment: .bottom)
                    .background(Color("white").edgesIgnoringSafeArea(.all))
                }
            }
            //ここまでがTabView

        }
        //TabViewを下部に画面いっぱいに表示


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            //      ContentView()
            //        .preferredColorScheme(.dark)
        }
    }
}


//▼道筋(仮)
//- 60秒のカウントダウンを3時間に変更
//- カウントダウンのカラーを30分以下で赤色
//- ResumeをDeleatボタンに変更。タップするとデリートダイアログが表示され(テキスト削除とカウントリセット)

