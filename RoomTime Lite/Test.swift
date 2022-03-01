//
//  Test.swift
//  RoomTime Lite
//
//  Created by Talaxy on 2022/2/23.
//

import Foundation
import Yams
import Markdown

let tags = [
    Tag(name: "hello", color: .red),
    Tag(name: "world", color: .orange),
    Tag(name: "cup", color: .yellow),
    Tag(name: "book", color: .green)
]

func test() {
//    let record = Record(raw: lmd)
//    print(record)
//    print(record.format)
    print("[Document Path]", Storage.document.path)
}

let lmd = """

---
authors:
    - Talaxy
date: 2022-02-24
tags:
    - swift
    - demo
---

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

"""

let md = """

---
authors:
    - "Talaxy"
date: 2022-02-24
tags:
    - swift
    - demo
---

# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6

# Quote

> An apple a day keeps the doctor away.

>> Quote can also be nested,
> > > and spaces are allowed bewteen arrows.

# List

* Unorder list

  - apple
  + banana
  * strawberry

* Order list

  1. eat
  2. code!
  3. sleep

  You can also specify the offset:
  
  11. eat
  2. code!
  3. sleep

# Code

Supports indent code:

    var name = "Talaxy"

and code block syntax:

```swift
// example
struct Demo: View {
    var body: some View {
        Text("Hello world!")
    }
}
```

# Border

---
* * *
__ ___ ____

# Table

Alignment syntax is supported.

| Property | Type   | Description |
|:-------- |:------:| -----------:|
| title    | String | The title of the news. |
| date     | Date   | The date of the news. |
| author   | String | The author ... |
"""
