//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by anatoly on 20.12.2021.
//

import SwiftUI

struct ContentView: View {
  
  @State private var capturedImage: UIImage? = nil
  @State private var isCustomCameraViewPresented = false
  @State var isAlert = false
  @State var text = "Press the button to log it"

    var body: some View {
      ZStack {
        if capturedImage != nil {
          Image(uiImage: capturedImage!)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        } else {
          Color(UIColor.systemBackground)
        }
        
        VStack {
          Spacer()
          Button(action: {isCustomCameraViewPresented.toggle()
          }, label: {
            Image(systemName: "camera.fill")
              .font(.largeTitle)
              .padding()
              .background(Color.black)
              .foregroundColor(.white)
              .clipShape(Circle())
          })
            .padding(.bottom)
            .sheet(isPresented: $isCustomCameraViewPresented, content: {
              CustomCameraView(capturedImage: $capturedImage)
            })
          showAlert()

          }
        }
      }
       
  
  fileprivate func showAlert() -> some View {
          return Button(action: {
              isAlert = true
          }, label: {
              Text("Trigger alert")
          }).alert(isPresented: $isAlert, content: {
              //Описание типа окна
              Alert(title: Text("Triggered Action"),
                    message: Text("Are you sure?"),
                    primaryButton: .default(Text("Yes"), action: {
                  print("Accepted")
                  text = "Accepted action from Alert button"
              }),
                    secondaryButton: .destructive(Text("Cancel"), action: {
                  print("Cancelled")
                  text = "Cancelled action from Alert button"
              })
              )
          }).buttonStyle(.bordered)
              .buttonBorderShape(.capsule)
      }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
        .previewDevice("iPhone 13")
    }
}
