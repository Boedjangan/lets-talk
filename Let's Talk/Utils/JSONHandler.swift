//
//  JSONHandler.swift
//  Let's Talk
//
//  Created by Bisma Mahendra I Dewa Gede on 18/07/23.
//

import Foundation

func loadJson<T: Decodable>(_ filename: String) -> T? {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
        
        return nil
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        
        return nil
    }
}

func loadJSONAsDict(_ filename: String) -> [[String: Any]]? {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
        return nil
    }
    
    return jsonArray
}
