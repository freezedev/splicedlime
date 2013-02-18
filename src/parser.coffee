StringReader = require './stringreader'

class CSSParser

  tokenNotFound = (expectedCharacter) ->
    (token) -> 
      token = if token then "'#{token}'" else "EOL"
      console.log "[WARN] Expected #{expectedCharacter}, got #{token}"

  constructor: (@input) ->

  parse: ->
    inputString = new StringReader(@input)

    parsedObject = {}

    loop
      break if inputString.end()

      currentToken = inputString.readUntil("{", true, tokenNotFound("{")).trim()
      selector = currentToken.trim()
      parsedObject[selector] = {}
      inputString.clearBuffer()

      selectorToken = inputString.readUntil("}", true, tokenNotFound("}")).trim()

      propString = new StringReader(selectorToken)
      loop
        break if propString.end()

        propToken = propString.readUntil(";", true, tokenNotFound(";")).trim()

        keyString = new StringReader(propToken)

        parsedKey = ""
        parsedValue = ""
        loop
          break if keyString.end()

          keyToken = keyString.readUntil(":", true).trim()

          unless parsedKey
            parsedKey = keyToken
          else
            parsedValue = keyToken

          keyString.clearBuffer()

        parsedObject[selector][parsedKey] = parsedValue
        
        propString.clearBuffer()

      inputString.clearBuffer()

    parsedObject
    
module.exports = CSSParser