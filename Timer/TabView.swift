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
                
                
                Image(systemName: "info.circle") // システムアイコンを指定
                    .resizable()
                    .frame(width: 24.0, height: 24.0, alignment: .leading)
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
                        .cancel()]
                )
            })
            //ここまでがダイアログの処理
            
        }
        .padding()
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    
    struct TabView_Previews: PreviewProvider {
        static var previews: some View {
            TabView()
        }
    }
    
}
