class StringReader
  buffer = ""

  constructor: (@input) ->
    @reset()

  readUntil: (character, omitCharacter = false, notFoundFn) ->
    loop
      if @end()
        notFoundFn(buffer) if notFoundFn
        break

      if character.length is 1
        break if @input[@currentIndex] is character
      else
        skip = true

        counter = 0
        for c in character
          unless @input[@currentIndex + counter] is c
            skip = false
            break

          counter++

        break if skip

      buffer += @input[@currentIndex]
      @currentIndex++

    @currentIndex += character.length if omitCharacter

    buffer

  clearBuffer: -> buffer = ""

  reset: ->
    @currentIndex = 0
    @clearBuffer()

  end: -> @currentIndex >= @input.length
  
module.exports = StringReader