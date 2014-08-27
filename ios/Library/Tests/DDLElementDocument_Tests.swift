/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
import XCTest

class DDLElementDocument_Tests: XCTestCase {

	let parser:DDLParser = DDLParser(locale:NSLocale(localeIdentifier: "es_ES"))

	override func setUp() {
		super.setUp()
	}

	override func tearDown() {
		super.tearDown()
	}

	func test_Parse_ShouldExtractValues() {
		parser.xml =
			"<root available-locales=\"en_US\" default-locale=\"en_US\"> " +
			"<dynamic-element dataType=\"document-library\" " +
				"indexType=\"keyword\" " +
				"name=\"A_Document\" " +
				"readOnly=\"false\" " +
				"repeatable=\"true\" " +
				"required=\"false\" " +
				"showLabel=\"true\" " +
				"type=\"ddm-documentlibrary\" " +
				"width=\"\"> " +
					"<meta-data locale=\"en_US\"> " +
						"<entry name=\"label\"><![CDATA[A Document]]></entry> " +
						"<entry name=\"predefinedValue\"><![CDATA[]]></entry> " +
					"</meta-data> " +
			"</dynamic-element> </root>"

		let elements = parser.parse()

		XCTAssertTrue(elements![0] is DDLElementDocument)
		let docElement = elements![0] as DDLElementDocument

		XCTAssertEqual(DDLElementDataType.DDLDocument, docElement.dataType)
		XCTAssertEqual(DDLElementEditor.Document, docElement.editorType)
		XCTAssertNil(docElement.predefinedValue)
		XCTAssertEqual("A_Document", docElement.name)
		XCTAssertEqual("A Document", docElement.label)
	}

	func test_Validate_ShouldFail_WhenRequiredValueIsNil() {
		parser.xml =
			"<root available-locales=\"en_US\" default-locale=\"en_US\"> " +
			"<dynamic-element dataType=\"document-library\" " +
				"indexType=\"keyword\" " +
				"name=\"A_Document\" " +
				"readOnly=\"false\" " +
				"repeatable=\"true\" " +
				"required=\"true\" " +
				"showLabel=\"true\" " +
				"type=\"ddm-documentlibrary\" " +
				"width=\"\"> " +
					"<meta-data locale=\"en_US\"> " +
						"<entry name=\"label\"><![CDATA[A Document]]></entry> " +
						"<entry name=\"predefinedValue\"><![CDATA[]]></entry> " +
					"</meta-data> " +
			"</dynamic-element> </root>"

		let elements = parser.parse()

		XCTAssertTrue(elements![0] is DDLElementDocument)
		let docElement = elements![0] as DDLElementDocument

		XCTAssertTrue(docElement.currentValue == nil)
		XCTAssertFalse(docElement.validate())
	}

}
