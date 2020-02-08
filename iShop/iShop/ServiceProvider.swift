import URLSession

let params = ["username":"john", "password":"123456"] as Dictionary<String, String>

var request = URLRequest(url: URL(string: "http://localhost:8080/api/1/login")!)
request.httpMethod = "POST"
request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
request.addValue("application/json", forHTTPHeaderField: "Content-Type")

let session = URLSession.shared
let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
    print(response!)
    do {
        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
        print(json)
    } catch {
        print("error")
    }
})

task.resume()