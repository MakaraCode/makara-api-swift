//
//  File.swift
//  
//
//  Created by Hugh Jeremy on 25/8/20.
//

import Foundation


protocol Model: Codable, PubliclyIdentified {
    
    static var path: String { get }

}

extension Model {
    
    func create(
        authenticatedBy session: Session?,
        then callback: @escaping (Error?, Self?) -> Void
    ) -> Void {
        
        let requestData: RequestData
        do {
            requestData = try RequestData(data: self)
        } catch {
            callback(error, nil)
            return
        }
        
        Request.make(
            path: Self.path,
            data: requestData,
            session: session,
            query: nil,
            method: .POST) { (error, data) in
                if error != nil {
                    callback(error, nil)
                }
                guard let data = data else {
                    callback(MakaraAPIError(.inconsistentState), nil)
                    return
                }
                let decoder = JSONDecoder()
                let output: Self
                do {
                    let objects = try decoder.decode(
                        [Self].self,
                        from: data
                    )
                    guard objects.count > 0 else {
                        callback(MakaraAPIError(.badResponse), nil)
                        return
                    }
                    output = objects[0]
                    callback(nil, output)
                } catch {
                    callback(error, nil)
                    return
                }
        }

    }
    
}
