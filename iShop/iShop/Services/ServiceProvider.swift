import Foundation
let defaultSession = URLSession(configuration: .default)
var dataTask: URLSessionDataTask?

func HTTPsendRequest() {
    
   let url = URL(string: "https://ichack20.herokuapp.com/tasks")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8))
    }
    task.resume()
}
