# Calculator App

A Flutter-based calculator application that supports basic arithmetic operations along with custom delimiter handling for strings of numbers. The app allows users to enter numbers in various formats (comma-separated, newline-separated, or custom delimiters) and calculate the sum of those numbers.

## Features

- **Basic Calculator:** Calculate the sum of numbers provided by the user.
- **Custom Delimiters:** Support for custom delimiters (`//<delimiter>\n<numbers>`) as well as multi-character delimiters.
- **Input Formats:** Support for multiple input formats:
  - Comma-separated (`1,2,3`)
  - Newline-separated (`1\n2\n3`)
  - Custom delimiters (`//;\n1;2`)
- **Error Handling:** Graceful handling of invalid inputs (e.g., invalid number formats, negative numbers).

## Installation

1. Clone the repository to your local machine:
   ```bash
   git clone https://github.com/neelamraj25/calculator_tdd.git
