{cssmin} = require('ycssmin')

JSONtoCSS = (object, options) ->

  JSONtoString = do (object) ->
    cssContent = ''
  
    for own key, value of object
      if typeof object is 'object'
        for own subKey, subValue of value
          cssContent += "#{key} {"
          if typeof subValue is 'object'
            cssContent += JSONtoString subValue
          else
            cssContent += "#{subKey}: #{subValue};"
          cssContent += '}'
     cssContent