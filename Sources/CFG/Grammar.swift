//
//  Grammar.swift
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

public class Grammar {
    public private(set) var terminals: Set<Terminal>
    public private(set) var nonterminals: Set<Nonterminal>
    public let rules: Set<Rule>
    public let start: Nonterminal

    private func createTerminalSet() {
        var ts: [Terminal] = []
        for rule in rules {
            for tailOption in rule.tail {
                for s in tailOption {
                    if let t = s as? Terminal {
                        ts.append(t)
                    }
                }
            }
        }

        terminals = Set(ts)
    }

    private func createNonterminalSet() {
        var nts: [Nonterminal] = []
        for rule in rules {
            nts.append(rule.head)
        }

        for rule in rules {
            for tailOption in rule.tail {
                for s in tailOption {
                    if let n = s as? Nonterminal {
                        nts.append(n)
                    }
                }
            }
        }

        nonterminals = Set(nts)
    }

    public init(rules: Set<Rule>, start: Nonterminal) {
        self.rules = rules
        self.start = start
        terminals = Set()
        nonterminals = Set()

        createNonterminalSet()
        createTerminalSet()
    }

    public func generate() -> [Terminal]? {
        return generate(from: [start as Symbol])
    }

    public func generate(from: [Symbol]) -> [Terminal]? {
        let derivation = Derivation(start: from, grammar: self)

        // TODO: what if derivation doesn't converge?
        while derivation.leftmost() != nil {
            derivation.step()
        }

        return derivation.result()
    }

    public func pickRule(v: Nonterminal) -> Rule? {
        let candidates = Array(rules).filter { $0.head == v }

        return candidates.randomElement()
    }
}
