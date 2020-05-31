//
//  Rule.swift
//  CFG
//
//  Created by Matthew M. Burke on 4/6/15.
//  Copyright (c) 2015-2020 BlueDino Software (http://bluedino.net)
//
//  Redistribution and use in source and binary forms, with or without modification, are permitted provided
//  that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright notice, this list of conditions
//     and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions
//     and the following disclaimer in the documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse
//     or promote products derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS
//  OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
//  FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
//  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR
//  TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

import Foundation

public class Rule: Hashable, Equatable {
    public let head: Nonterminal
    public let tail: [[Symbol]]

    // TODO: is this reasonable?
    public func hash(into hasher: inout Hasher) {
        hasher.combine(head.hashValue)
        for element in tail {
            for item in element {
                hasher.combine(item)
            }
        }
    }

    public init(head: Nonterminal, tail: [Symbol]) {
        self.head = head
        self.tail = [tail]
    }

    public init(head: Nonterminal, tail: [[Symbol]]) {
        self.head = head
        self.tail = tail
    }

    public func apply(to intermediate: [Symbol]) -> [Symbol] {
        var newState = intermediate

        if let index = newState.firstIndex(of: head) {
            let selectedTail = tail.randomElement()!
            newState.replaceSubrange(index...index, with: selectedTail)
        }

        return newState
    }

    public static func ==(lhs: Rule, rhs: Rule) -> Bool {
        return (lhs.head == rhs.head && lhs.tail == rhs.tail)
    }
}

precedencegroup SubstitutionPrecedence {}

infix operator --> : SubstitutionPrecedence

public func -->(head: Nonterminal, tail: [Symbol]) -> Rule {
    return Rule(head: head, tail: tail)
}

public func -->(head: Nonterminal, tail: [[Symbol]]) -> Rule {
    return Rule(head: head, tail: tail)
}

precedencegroup AlternativePrecedence {
    higherThan: SubstitutionPrecedence
    associativity: left
}

// If I use "|" then Swift thinks it's an Arithmetic Operator
// TODO: anyway to override that?
infix operator ||| : AlternativePrecedence

public func |||(lhs: [Symbol], rhs: [Symbol]) -> [[Symbol]] {
    return [lhs, rhs]
}

public func |||(lhs: [[Symbol]], rhs: [Symbol]) -> [[Symbol]] {
    var result = Array(lhs)
    result.append(rhs)
    return result
}
