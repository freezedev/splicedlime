CSSParser = require './parser'

input = "#selector { width: 50px; } .other-selector { height: 60px; width: 100px; background-color: #fff; }"

parser = new CSSParser(input)
console.log parser.parse()