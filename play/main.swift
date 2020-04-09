//
//  main.swift
//  play
//
//  Created by sebprest on 09/04/2020.
//  Copyright © 2020 sebprest. All rights reserved.
//

import Foundation

let userArgs = Array(ProcessInfo.processInfo.arguments.dropFirst())

// print the help message when appropriate
if userArgs.count == 0 || userArgs.contains(where: { $0 == "--help" || $0 == "-h" }) {
  print(
    """
    Usage: play [options] [file]

    Options:
      --help | -h:
        Print this message.
    """)
  exit(0)
}
