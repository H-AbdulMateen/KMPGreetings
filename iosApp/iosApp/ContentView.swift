import SwiftUI
import shared

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
	let greet = Greeting().greet()

	var body: some View {
        ListView(phrases: viewModel.greetings).onAppear(){
            self.viewModel.startObserving()
        }
	}
}
// ...
extension ContentView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var greetings: [String] = []
        
        func startObserving() {
            Task {
                    for await phrase in Greeting().greet() {
                        self.greetings.append(phrase)
                    }
            }
        }
    }
}

struct ListView: View {
    let phrases: Array<String>

    var body: some View {
        List(phrases, id: \.self) {
            Text($0)
        }
    }
}
//struct ContentView_Previews: PreviewProvider {
//	static var previews: some View {
//		ContentView(viewModel: ContentView.ViewModel)
//	}
//}
