//
//  PODContentView.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import SwiftUI

struct PODContentView: View {
    @StateObject var viewModel: PODViewModel = PODViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.podData?.title ?? "")
                    .font(.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .bottom, .trailing])

                ZStack {
                    VStack{
                        Spacer()
                        if viewModel.isLoading {
                            ProgressView()
                        }
                        Spacer()
                    }
                    if let image = viewModel.podImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .clipped()
                    }
                }
                
                Text(viewModel.podData?.date ?? "")
                    .italic()
                    .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        Text(viewModel.podData?.explanation ?? "")
                            .font(.body)
                            .fontWeight(.regular)
                            .multilineTextAlignment(.center)
                            .padding(.all)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("NASA - Photo of Day")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchPODData()
        }
        .alert(viewModel.alertMessage,
               isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

struct PODContentView_Previews: PreviewProvider {
    static var previews: some View {
        PODContentView()
    }
}
