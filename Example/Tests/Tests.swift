// https://github.com/Quick/Quick

import Quick
import Nimble
import Swiftcraft

import SwiftSockets

func htons(value: CUnsignedShort) -> CUnsignedShort {
    // hm, htons is not a func in OSX and the macro is not mapped
    return (value << 8) + (value >> 8);
}


class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("these will pass") {

            it("can do maths") {
                expect(1) == 1
            }

            it("can connect to IBM") {
                var addr: sockaddr_in!

                gethoztbyname("www.ibm.com") { (_, _, a: sockaddr_in?) in
                    guard a != nil else {
                        print("Unable to get DNS entry for www.ibm.com")
                        return
                    }
                    addr = a!
                }

                guard addr != nil else {
                    print("Unable to get DNS entry for www.ibm.com")
                    return
                }

                addr.sin_port = in_port_t(htons(CUnsignedShort(80)))

                let socket: ActiveSocket<sockaddr_in>! = ActiveSocket<sockaddr_in>()

                socket.onRead { sock, _ in
                    let (count, block, errno) = sock.read()
                    guard count > 0 else {
                        print("EOF, or great error handling \(errno).")
                        return
                    }
                    print("Answer to ring,ring is: \(count) bytes: \(block)")
                }

                let isConnected = socket.connect(addr) { socket in
                    socket.write("GET /us-en/ HTTP/1.1\r\nHost: www.ibm.com\r\n\r\n")
                }

                expect(isConnected) == true
            }

            it("can read") {
                expect("number") == "number"
            }

            it("will eventually fail") {
                expect("time").toEventually(equal("time"))
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
