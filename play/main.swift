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
        
        // output the currently playing file to the console
        print("Playing \(audioPlayer.url!.lastPathComponent)")
        
        // stay open while the song is still playing
        while audioPlayer.currentTime < audioPlayer.duration {
            switch readLine() {
              case Constants.SEEK_FORWARD_KEY:
                  print("Seeking forward \(Constants.SEEK_AMOUNT) seconds")
                  audioPlayer.currentTime += Constants.SEEK_AMOUNT
              case Constants.SEEK_BACKWARD_KEY:
                  print("Seeking backward \(Constants.SEEK_AMOUNT) seconds")
                  audioPlayer.currentTime -= Constants.SEEK_AMOUNT
              case Constants.PLAY_PAUSE_KEY:
                  if audioPlayer.isPlaying {
                      print("Pausing")
                      audioPlayer.pause()
                  } else {
                      print("Playing")
                      audioPlayer.play()
                  }
              default:
                  break
              }
        }
    } catch {
        print("Error initialising audio player: \(error)")
        exit(1)
    }
} else {
    print("File \(fileURL!.lastPathComponent) does not exist")
    exit(1)
}
