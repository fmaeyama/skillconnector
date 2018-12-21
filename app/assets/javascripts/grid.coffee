# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@download_file = (contents, filename) ->
  blob = new Blob([contents],["type":"text/plain"])
  if window.navigator.msSaveBlob # for only IE
    window.navigator.msSaveOrOpenBlob(blob, filename)
  else # for other browser
    url = URL.createObjectURL(new Blob([contents]))
    a = document.createElement('A')
    a.download = filename
    a.href = url
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
