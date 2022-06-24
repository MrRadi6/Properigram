//
//  ContentView.swift
//  Properigram
//
//  Created by Samir on 6/24/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                let repository = PropertyRepository(remote: PropertyAPI())
                repository.getPropertyDetails(with: "026cc6cc-d2ca-4f99-871e-f1b7b0c7ba29") { result in
                    switch result {
                    case .success(let page):
                        print(page)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
