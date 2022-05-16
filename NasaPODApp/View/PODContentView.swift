//
//  PODContentView.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import SwiftUI

struct PODContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("POD Title")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .bottom, .trailing])

                
                Image(uiImage: UIImage())
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .clipped()
                
                Text("POD Date")                    .padding(.horizontal)
                
                
                Text("POD Explanation")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
                    .padding(.all)
                                    
                Spacer()
            }
                .padding()
                .navigationTitle("NASA - Photo of Day")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct PODContentView_Previews: PreviewProvider {
    static var previews: some View {
        PODContentView()
    }
}
