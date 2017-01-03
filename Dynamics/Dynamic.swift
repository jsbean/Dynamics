//
//  Dynamic.swift
//  Dynamics
//
//  Created by James Bean on 4/27/16.
//
//


/**
 Structure defining a single instance of a musical dynamic (e.g., f, p, o, mp, mf).
 
 One or more `Dynamic.Element` objects are aggregated to create a `Dynamic`.
 
 One or more `Dynamic` objects are aggregated to create a `Dynamic.Cluster`.
 */
public struct Dynamic {
    

    // MARK: - Instance Properties
    
    public var isVirtual: Bool = false
    
    fileprivate let elements: [Element]
    
    // MARK: - Initializers
    
    public init(_ elements: [Element]) {
        self.elements = elements
    }
}

extension Dynamic {
    
    // MARK: Integer Value
    
    fileprivate var integerValue: Int {
        
        if elements == [.niete] {
            return Int.min
        } else if elements == [.mezzo, .forte] {
            return 1
        } else if elements == [.mezzo, .piano] {
            return -1
        } else if elements.first == .forte {
            return elements.count + 1
        } else if elements.first == .piano {
            return -1 * (elements.count + 1)
        }
        
        fatalError("Poorly formed Dynamic")
    }
}

extension Dynamic: Equatable { }

/**
 - returns: `true` if two `Dynamic` values are logically equivalent. Otherwise `false`.
 */
public func == (lhs: Dynamic, rhs: Dynamic) -> Bool {
    return lhs.integerValue == rhs.integerValue
}

extension Dynamic: Comparable { }

/// - returns: `true` if the left `Dynamic` value is logically less than the right.
/// Otherwise `false`.
public func < (lhs: Dynamic, rhs: Dynamic) -> Bool {
    return lhs.integerValue < rhs.integerValue
}

extension Dynamic: CustomStringConvertible {
    
    /// Printable description
    public var description: String {
        return elements.reduce("") { accum, element in accum + element.rawValue }
    }
}
