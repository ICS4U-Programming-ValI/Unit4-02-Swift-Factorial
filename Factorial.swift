import Foundation

/**
 * Created by Val I on 2025-04-21
 * Version 1.0
 * Copyright (c) 2025 Val I. All rights reserved.
 *
 * The Factorial program reads an int from a file
 * and finds the factorial using recursion.
 *
 */

enum FactorialError: Error {
    case invalidInput
}
// This function calculates factorial using recursion.
func factorial(_ number: Int) -> Int {
    if number == 0 {
        return 1;
    } else {
        return number * factorial(number - 1);
    }
}

// File paths
let inputFilePath = "./input.txt"
let outputFilePath = "./output.txt"

// Open the input file for reading
guard let input = FileHandle(forReadingAtPath: inputFilePath) else {
    print("Error: can't find input file")
    exit(1)
}

// Open the output file for writing
guard let output = FileHandle(forWritingAtPath: outputFilePath) else {
    print("Error: can't open output file")
    exit(1)
}

// Read the contents of the input file
let inputData = input.readDataToEndOfFile()

// Convert the data to a string
guard let inputString = String(data: inputData, encoding: .utf8) else {
    print("Error: can't convert input data to string")
    exit(1)
}

// Split the string into lines
let inputLines = inputString.components(separatedBy: .newlines)

// Process each line
for line in inputLines {
    if !line.isEmpty {
        do {
            // Try to cast the line to an integer
            if let number = Int(line) {
                if number > 10 {
                    let warningMessage = "Factorial is too large.\n"
                    output.write(warningMessage.data(using: .utf8)!)
                } else if number < 0 {
                    let warningMessage = "Number is negative.\n"
                    output.write(warningMessage.data(using: .utf8)!)
                } else {
                    // Calculate the factorial of the number
                    let factorialResult = factorial(number)
                    let message = "Factorial of \(number): \(factorialResult)\n"
                    output.write(message.data(using: .utf8)!)
                }
            } else {
            throw FactorialError.invalidInput
            }
        } catch FactorialError.invalidInput {
            let errorMessage = "Invalid input '\(line)'. Not an integer.\n"
            output.write(errorMessage.data(using: .utf8)!)
        
        }

    }
}

// Close the input and output files
input.closeFile()
output.closeFile()