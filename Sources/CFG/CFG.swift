//
//  Types.swift
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

// TODO: make symbols flyweights?
public class Symbol: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    // TODO: this may be not a valid approach?
    public static func ==(lhs: Symbol, rhs: Symbol) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

// NOTE: I cannot remember what I intended here...
public class PrintingSymbol: Symbol, ExpressibleByStringLiteral, CustomStringConvertible {
    let s: String

    override init() {
        s = ""
    }

    public required init (stringLiteral s: String) {
        self.s = s
    }

    public var description: String {
        get {
            return s
        }
    }

    static func ==(lhs:PrintingSymbol, rhs: PrintingSymbol) -> Bool {
        return lhs.s == rhs.s
    }
}

public class Terminal: PrintingSymbol {}

// TODO: do nonterminals really need to be pritingsymbols?
public class Nonterminal: PrintingSymbol {}

// MARK: - convenience methods

public func T(_ s: String) -> Terminal {
  return Terminal(stringLiteral: s)
}

public func N(_ s: String) -> Nonterminal {
  return Nonterminal(stringLiteral: s)
}
