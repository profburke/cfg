## CFG

This package is a simple implementation of library to use Context-free Grammars to generate text. It is
a re-incarnation of code I originally wrote in 2015 and is still in a very rough state. At this point, basically
all that I have done is made changes so that it would compile under 5.x Swift.

There are a number of design decisions from the original code whose intent I no longer remember.
I recently attended !!Con 2020 and through talks there learned about BlurML and Tracery. I may
try and incorporate some of the ideas from those projects; particularly Tracery's applicability to more
than just text generation. However, my primary motivation in resurrecting this code is that I plan to
use it in a couple of specific projects. This should hopefully help me pin down some of the design
issues I'm struggling with and I'll back-port improvements from those projects to here.

### Installation

Modify your Package.swift file to include CFG as a dependency:

```swift
.package(url: "https://github.com/profburke/cfg.git", from: "0.1.0")
```
*NOTE: Although I will try to keep this README file up to date, you may need to update the version number
from the above. Check the tags on the github repo for the latest version.*

You need to also include "CFG" in your list of target dependencies.

### Example

```
import CFG

// Define terminals and nonterminals:

let START: Nonterminal = "START"
let HOWNOW: Terminal = "How now"
let ADJECTIVES: Nonterminal = "ADJECTIVES"
let ADJECTIVE: Nonterminal = "ADJECTIVE"
let MAMMAL: Nonterminal = "MAMMAL"

// Define production rules. Note the use of the `T` helper method for incidental terminals:

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

    print(derivation.result ?? "no result")
}
```


### Contributions

Contributions are welcome. And if you do contribute, thank you for your time and effort!

There are many ways to contribute in addition to submitting code. Bug reports, feature suggestions, a logo for the project, and improvements to documentation are all appreciated.

##### Bug Reports and Feature Suggestions

Please submit bug reports and feature suggestions by creating a [new issue](https://github.com/profburke/cfg/issues/new). If possible, look for an existing [open issue](https://github.com/profburke/bgurt/issues) that is related and comment on it.

When creating an issue, the more detail, the better. For bug reports in partciular, try to include at least the following information:

* The application version
* The operating system (macOS, Windows, etc) and version
* The expected behavior
* The observed behavior
* Step-by-step instructions for reproducing the bug


##### Pull Requests

Ensure the PR description clearly describes the problem and solution. It should include the relevant issue number, if applicable.


##### Documentation Improvements

Preferably, submit documentation changes by pull request. However, feel free to post your changes to an [issue](https://github.com/profburke/cfg/issues/new) or send them to the project team.

It would be nice to have a site for this project that we could host on Github Pages. If you have an interest in helping build that, please let me know.


### License

This project is licensed under the BSD 3-Clause License. For details, please read the [LICENSE](https://github.com/profburke/cfg/blob/master/LICENSE) file.
