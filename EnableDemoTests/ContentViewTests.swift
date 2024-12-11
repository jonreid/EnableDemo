@testable import EnableDemo
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class ContentViewTests: XCTestCase {
    func test_initiallyDisabled() throws {
        let sut = ContentView()

        let isEnabled = try sut.inspect().find(viewWithTag: "customButton").button().isResponsive()

        XCTAssertFalse(isEnabled)
    }

    func test_enable() throws {
        var sut = ContentView()
        var isEnabled = false

        let expectation = sut.on(\.viewInspectorHook) { view in
            try view.find(ViewType.Toggle.self).tap()
            isEnabled = try view.find(viewWithTag: "customButton").button().isResponsive()
        }
        ViewHosting.host(view: sut)
        defer { ViewHosting.expel() }
        wait(for: [expectation], timeout: 0.4)

        XCTAssertTrue(isEnabled)
    }

    func test_customButtonDisabledColor() throws {
        let sut = ContentView()

        let color = try sut.inspect().find(viewWithTag: "customButton").button()
            .labelView().shape().fillShapeStyle(Color.self)

        XCTAssertEqual(color, .gray)
    }

    func test_customButtonEnabledColor() throws {
        var sut = ContentView()
        var color: Color?

        let expectation = sut.on(\.viewInspectorHook) { view in
            try view.find(ViewType.Toggle.self).tap()
            color = try view.find(viewWithTag: "customButton").button()
                .labelView().shape().fillShapeStyle(Color.self)
        }
        ViewHosting.host(view: sut)
        defer { ViewHosting.expel() }
        wait(for: [expectation], timeout: 0.4)

        XCTAssertEqual(color, .blue)
    }
}
