//
//  ContentView.swift
//  TestTek
//
//  Created by Nicolas Bellon on 02/08/2022.
//

import SwiftUI

struct ContentView: View {

    let viewModel = ViewModelFactory.generateListViewModel()
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear() {
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
