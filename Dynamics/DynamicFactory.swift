//
//  DynamicFactory.swift
//  Dynamics
//
//  Created by James Bean on 4/27/16.
//
//

import Foundation
import ArrayTools
import StringTools

public class DynamicFactory {
    
    // TODO: refine cases
    public enum Error: ErrorType {
        case InvalidString(String)
        case Empty(String)
        case TooManyCharacters(String)
        case InvalidCharacter(String)
        case InvalidElements(String)
    }
    
    // TODO: isVirtual
    // TODO: isSubito

    private let string: String
    
    public init(string: String) {
        self.string = string
    }
    
    // TODO: check if isVirtual
    public func makeDynamic() throws -> Dynamic {
        try ensureNotEmpty(string: string)
        let unverifiedElements = try makeUnverifiedElements(withString: string)
        let verifiedElements = try verifyElements(unverifiedElements)
        return Dynamic(elements: verifiedElements)!
    }
    
    // TODO: flesh out
    private func verifyElements(elements: [DynamicElement]) throws -> [DynamicElement] {
        guard let (head, tail) = elements.destructured else {
            throw Error.InvalidElements(elements.description)
        }
        
        switch head {
        case .Mezzo:
            guard let next = tail.first else { throw Error.InvalidString(string) }
            switch next {
            case .Piano, .Forte: break
            default: throw Error.InvalidString("")
            }
        case .Forte: if tail.isHeterogeneous { throw Error.InvalidString(string) }
        case .Piano: if tail.isHeterogeneous { throw Error.InvalidString(string) }
        case .Niente:
            if tail.first != nil { throw Error.InvalidString(string) }
            
        //case .S: break
        //case .R: break
        //case .Z: break
        }
        return elements
    }

    
    /*
    private func checkVirtuality(withString string: String) throws -> Bool {
        guard string.characters.count > 2 else { throw Error.InvalidString(string) }
        switch string.characters.first! {
        case "(":
            switch string.characters.last! {
            case ")": return true
            default: throw Error.InvalidString(string)
            }
        default: return false
        }
    }
    */
    
    private func makeUnverifiedElements(withString string: String) throws -> [DynamicElement] {
        let result = string.characters.flatMap { DynamicElement(rawValue: String($0)) }
        if result.count != string.characters.count { throw Error.InvalidString(string) }
        return result
    }
    
    private func ensureNotEmpty(string string: String) throws {
        if string.characters.count == 0 { throw Error.Empty(string) }
    }
}