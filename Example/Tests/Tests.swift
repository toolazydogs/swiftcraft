// https://github.com/Quick/Quick

import Quick
import Nimble
import Swiftcraft

import SwiftSockets

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("these will pass") {

            it("can do maths") {
                expect(1) == 1
            }

            it("can connect to IBM") {
                let socket = ActiveSocket<sockaddr_in>()
                let isConnected = socket!.onRead { sock, _ in
                    let (count, block, errno) = sock.read()
                    guard count > 0 else {
                        print("EOF, or great error handling \(errno).")
                        return
                    }
                    print("Answer to ring,ring is: \(count) bytes: \(block)")
                }
                .connect("23.64.166.184:80") { socket in
                        socket.write("GET /us-en/ HTTP/1.1\r\nHost: www.ibm.com\r\n\r\n")
                }
                expect(isConnected) == true
            }

            it("can read") {
                expect("number") == "number"
            }

            it("will eventually fail") {
                expect("time").toEventually( equal("time") )
            }
            
            context("these will pass") {

                it("can do maths") {
                    expect(23) == 23
                }

                it("can read") {
                    expect("🐮") == "🐮"
                }

                it("will eventually pass") {
                    var time = "passing"

                    dispatch_async(dispatch_get_main_queue()) {
                        time = "done"
                    }

                    waitUntil { done in
                        NSThread.sleepForTimeInterval(0.5)
                        expect(time) == "done"

                        done()
                    }
                }
            }
        }
    }
}
