//
//  APICaller.swift
//  NewsApp
//
//  Created by Vaibhav  Tiwary on 26/04/25.
//

import Foundation
final class APICaller{
    static let shared = APICaller()
    
    struct Constants{
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=ca907de8a1a4483f91eb43acb5940b5f")
    }
                                      
                                      private init(){}
    
    public func getTopStories(completion:@escaping(Result<[Article],Error>)->Void){
        guard let url = Constants.topHeadlinesURL else{return}
        
        let task = URLSession.shared.dataTask(with: url){data, _, error in
            if let error = error{
                completion(.failure(error))
            }else if let data = data {
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                }catch{
                    completion(.failure(error))
                    
                }
                
            }
            
        }
        
        task.resume()
        
        
    }
}

struct APIResponse:Codable{
    let articles :[Article]
}

struct Article:Codable{
    let source :Source
    let title :String
    let description:String?
    let url :String?
    let urlToImage :String?
    
    let publishedAt:String?
    
}

struct Source:Codable{
    let name : String
}



