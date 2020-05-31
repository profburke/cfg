//
//  Derivation.swift
//  CFG
//
//  Created by Matthew M. Burke on 4/7/15.
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

public class Derivation {
    // NOTE: start is an array because we may want to start a derivation from
    //       an intermediate step
    public let start: [Symbol]
    public let grammar: Grammar
    private(set) var intermediates: [[Symbol]]

    public init(start: [Symbol], grammar: Grammar) {
        self.start = start
        self.grammar = grammar
        intermediates = [start]
    }

    public func leftmost() -> Nonterminal? {
        if let currentState = intermediates.last {
            for s in currentState {
                if let nt = s as? Nonterminal {
                    return nt
                }
            }
        }

        return nil
    }

    public func isComplete() -> Bool {
        return leftmost() == nil
    }

    public func result() -> [Terminal]? {
        guard isComplete(), let result = intermediates.last as? [Terminal] else {
            return nil
        }

        return result
    }

    // TODO: what if lets fail? should we signal somehow? throw?
    public func step() {
        if let leftmost = leftmost(), let rule = grammar.pickRule(v: leftmost),
            let currentState = intermediates.last {
            intermediates.append(rule.apply(to: currentState))
        }
    }
}
