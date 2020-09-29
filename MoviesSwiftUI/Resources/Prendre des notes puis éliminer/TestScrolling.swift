//
//  TestScrolling.swift
//  MoviesSwiftUI
//
//  Created by cristian on 29/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct TestScrolling: View {
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0...20, id: \.self) { count in
//                    (count % 2 == 0 ? Color.red : Color.blue)
//                        .frame(height: 44.0)
//                    NavigationLink(destination: MoviesListView(moviesViewModel: MoviesListViewModel(), title: "Test", endpoint: "popular")) {
//                        Text("Click me")
//                    }
                }
            }
            .background(NavigationConfigurator { nc in // NavigationConfigurator is from the OP's post: https://stackoverflow.com/a/58427754/7834914
                nc.hidesBarsOnSwipe = true
            })
            .navigationBarTitle("Hello World", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct TestScrolling_Previews: PreviewProvider {
    static var previews: some View {
        TestScrolling()
    }
}


struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}
