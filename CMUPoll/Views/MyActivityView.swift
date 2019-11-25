//
//  MyActivityView.swift
//  CMUPoll
//
//  Created by 이시헌 on 2019/11/18.
//  Copyright © 2019 Aiden Lee. All rights reserved.
//

import SwiftUI
import UIKit

struct MyActivityView: View {
  
  let user = User.current
  @State var polls = [Poll]()
  
  @State private var chosenView = 0
  
  var body: some View {
    NavigationView {
      VStack(alignment: .leading, spacing: 10) {
        Picker(selection: $chosenView, label: Text("")) {
          Text("Uploaded Polls").tag(0)
          Text("Answered Polls").tag(1)
        }.pickerStyle(SegmentedPickerStyle())
          .padding(.vertical, 10)
          .padding(.horizontal, 16)
          
        
        
        Text("My Activity")
          .font(Font.system(size: 20, design: .default))
          .fontWeight(.bold)
          .foregroundColor(Color.gray)
          .padding(.horizontal, 16)
        
        List {
          
          ForEach(self.polls) { poll in
            NavigationLink(destination: PollDetailView(poll: poll)) {
              PollView(poll: poll)
            }
          }
        }
        .navigationBarTitle(Text("CMUPoll"), displayMode: .inline)
        .navigationBarItems(trailing:
          // TODO: should connect to a form view
          NavigationLink(destination: PollCreateView(refresh: self.getUploadedPolls)) {
            Text("Add")
          }
        )
      }
      
    }
    .onAppear {
      self.getUploadedPolls()
    }
  }
  
  // need to get sorted polls (my answered polls)
  func getUploadedPolls() {
    if let user = self.user {
      user.polls(completion: { polls in
      DispatchQueue.main.async {
        self.polls = polls
      }
    })
    }
  }

}

struct MyActivityView_Previews: PreviewProvider {
  static var previews: some View {
    MyActivityView()
  }
}