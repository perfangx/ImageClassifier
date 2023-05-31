//
//  ContentView.swift
//  TestingImageClasifier
//
//  Created by roba on 29/05/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showImagePicker: Bool = false
    @State private var selectedUIimage: Optional<UIImage> = .none
    @StateObject private var ImageClassifier: ImageClassifier = .init()
    var body: some View {
        VStack{
            if let selectedUIimage = selectedUIimage{
                Image(uiImage: selectedUIimage)
                    .resizable()
                    .scaledToFit()
            }
            Button {
                //  print("im clicked")
                showImagePicker.toggle()
            } label: {
                Text("click me")
            }
            
            ScrollView{
                ForEach(ImageClassifier.predictions){ prediction in
                    HStack {
                        Text(prediction.label)
                        Text(prediction.confidence.description)
                    }
                }
            }

        }
        
        .sheet(isPresented: $showImagePicker
        ,onDismiss: {
        guard let selectedImage = selectedUIimage else {
        return
        }
            ImageClassifier.predict(image: selectedImage)
        },
        content: {
        imagePicker(image: $selectedUIimage)

            })
           
      
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
