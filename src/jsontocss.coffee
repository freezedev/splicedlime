{cssmin} = require('ycssmin')

JSONtoCSS = (object, options) ->

  JSONtoString = (object) ->
    cssContent = ''
    queue = []
  
    for own key, value of object
      if typeof object is 'object'
        for own subKey, subValue of value
          cssContent += "#{key} {"
          if typeof subValue is 'object'
            console.log subValue
            newObject = {}
            newObject[subKey] = subValue
            queue.push JSONtoString newObject
          else
            cssContent += "#{subKey}: #{subValue};"
          cssContent += '}'

          
        
       for q in queue
         cssContent += "#{key} #{q}"

     cssContent

  JSONtoString object