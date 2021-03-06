//
//  SchemaToModelEnumTransformer.swift
//  GoogleServiceGenerator
//
//  Created by Matthew Wyskiel on 10/17/15.
//  Copyright © 2015 Matthew Wyskiel. All rights reserved.
//

import Cocoa
import GoogleAPIs

class SchemaToModelEnumTransformer {
    var serviceName: String = Generator.sharedInstance.serviceName
    
    func enumFromSchema(_ propertyName: String, resourceName: String, propertyInfo: DiscoveryJSONSchema) -> ModelEnum {
        // 1) Name
        let enumName = serviceName + resourceName.objcName(shouldCapitalize: true) + propertyName.objcName(shouldCapitalize: true)
        // 1) Type
        var enumType: String = ""
        if let typeEnumType = Types.type(forDiscoveryType: propertyInfo.type, format: propertyInfo.format) {
            if propertyInfo.enumValues != nil {
                enumType = typeEnumType.rawValue
            }
        }
        // 1a) Type Description
        let typeDescription = propertyInfo.schemaDescription != nil ? propertyInfo.schemaDescription : ""
        // 2) Cases
        var enumCases = propertyInfo.enumValues
        if enumType == "String" {
            enumCases = propertyInfo.enumValues.map { (rawValue) -> String in
                return "\"\(rawValue)\""
            }
        }
        // 3) CaseNames
        let caseNames = propertyInfo.enumValues.map { (rawValue) -> String in
            if let value = OverrideFileManager.overrideAPIEnumCaseNames(resourceName: resourceName, propertyName: propertyName, input: rawValue) {
                return value
            }
            
            return rawValue.objcName(shouldCapitalize: false)
        }
        // 3a) Case Descriptions
        let caseDescriptions = propertyInfo.enumDescriptions
        // 4) put it all together
        return ModelEnum(name: enumName, type: enumType, typeDescription: typeDescription!, cases: enumCases!, caseNames: caseNames, caseDescriptions: caseDescriptions!)
    }
}
