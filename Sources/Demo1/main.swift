//
//  main.swift
//  CFG.Demo1
//  
//
//  Created by Matthew M. Burke on 5/31/20.
//  Copyright (c) 2020 BlueDino Software (http://bluedino.net)
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

import CFG

// https://en.wikipedia.org/wiki/How_now_brown_cow

// need to think this through more...
// also, note use of T(" ") in the start rule below is a hack...
func format(_ derivation: [Terminal]) -> String {
    var result = ""
    for terminal in derivation {
        result += "\(terminal)"
    }
    return result
}

let START: Nonterminal = "START"
let HOWNOW: Terminal = "How now"
let ADJECTIVES: Nonterminal = "ADJECTIVES"
let ADJECTIVE: Nonterminal = "ADJECTIVE"
let MAMMAL: Nonterminal = "MAMMAL"

let rules = Set<Rule>([
    START --> [HOWNOW, T(", "), ADJECTIVES, T(" "), MAMMAL, T(".")],

    ADJECTIVES --> [ADJECTIVES, T(", "), ADJECTIVE] ||| [ADJECTIVE],

    ADJECTIVE --> [T("brown")] ||| [T("big")] ||| [T("scary")],

    MAMMAL --> [T("cow")] ||| [T("wolf")] ||| [T("bear")]
])

let grammar = Grammar(rules: rules, start: START)

for _ in 0..<10 {
    let derivation = Derivation(start: [START], grammar: grammar)

    while !derivation.isComplete() {
        derivation.step()
    }

    if let result = derivation.result() {
        print(format(result))
    } else {
        print("no result")
    }
}

