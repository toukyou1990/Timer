//
//  TabView.swift
//  Timer
//
//  Created by Notty on 2020/11/22.
//

import SwiftUI

struct TabView: View {
    
    @State var isShown = false
    
    var body: some View {

        HStack {
            
            VStack(alignment: .leading) {
                Button(action: {
                }){
                    Image(systemName: "info.circle")
                        .resizable()
                        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                        .frame(width: 24.0, height: 24.0, alignment: .leading)
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
    
    
    struct TabView_Previews: PreviewProvider {
        static var previews: some View {
            TabView()
        }
    }
    
}
