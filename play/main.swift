//
//  main.swift
//  play
//
//  Created by sebprest on 09/04/2020.
//  Copyright © 2020 sebprest. All rights reserved.
//

import Foundation
import MediaPlayer

let userArgs = Array(ProcessInfo.processInfo.arguments.dropFirst())
let currentDirURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)

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

// get the first argument as a URL so that it can be easily handled by AVAudioPlayer
let fileURL = URL(
    string: userArgs.first!,
    relativeTo: currentDirURL
)

// check that the file specified in the passed in URL actually exists
if FileManager.default.fileExists(atPath: fileURL!.path) {
    do {
        // initialise an AVAudioPlayer object with the passed in URL
        let audioPlayer = try AVAudioPlayer(contentsOf: fileURL!)
        // play the audio file
        audioPlayer.play()
        
        // stay open while the song is still playing
        while audioPlayer.currentTime < audioPlayer.duration {
            wait()
        }
    } catch {
        print("Error initialising audio player: \(error)")
        exit(1)
    }
} else {
    print("File \(fileURL!.lastPathComponent) does not exist")
    exit(1)
}
