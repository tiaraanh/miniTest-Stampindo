import Foundation
import PlaygroundSupport

// Set up URL and API key
let apiKey = "USE YOUR API KEY"
let city = "Jakarta"
let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)")!

let request = URLRequest(url: url)
let session = URLSession.shared

let task = session.dataTask(with: request) { (data, response, error) in
    
    // Check for errors
    if let error = error {
        print("error: \(error)")
        return
    }
    
    // Check response status code
    if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode != 200 {
            print("invalid response: \(httpResponse.statusCode)")
            return
        }
    }
    
    // Make sure data available
    guard let data = data else {
        print("no data received")
        return
    }
    
    // Parse data as JSON
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            if let list = json?["list"] as? [[String: Any]] {
                
                var previousDate = ""

                for forecast in list {
                    if let dtTxt = forecast["dt_txt"] as? String,
                       let main = forecast["main"] as? [String: Any],
                       let temperature = main["temp"] as? Double {

                        // Extract and Format date from dtTxt
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        if let date = dateFormatter.date(from: dtTxt) {
                            dateFormatter.dateFormat = "EEE, d MMM yyyy:"
                            let formattedDate = dateFormatter.string(from: date)
                            
                            // Convert temperature to Celsius
                            let temperatureCelsius = temperature - 273.15
                            let formattedTemperature = String(format: "%.2f", temperatureCelsius)
                            
                            // Check if date is different from previous date
                            if formattedDate != previousDate {
                                print("\(formattedDate) \(formattedTemperature)°C")

                                // Update the previous date
                                previousDate = formattedDate
                            }
                        }
                    }
                }
            }
        } catch {
            print("error parsing JSON: \(error)")
        }
}

task.resume()

PlaygroundPage.current.needsIndefiniteExecution = true

