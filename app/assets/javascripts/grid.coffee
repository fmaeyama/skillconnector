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

@download_csv = (filename) ->
  download_file get_csv_content(),filename
@download_yaml = (filename) ->
  download_file get_yaml_content(), filename

convert_to_csv_str = (ret, str)->
  if typeof str == "string"
    str.replace("\"","\"\"") if str.length > 0
  else
    console.log(str)
  ret[0] = if ret[0].length == 0 then "\"#{str}\"" else "#{ret[0]},\"#{str}\""


@get_csv_content = () ->
  ret = []
  get_header_line = (ret, obj_arr) ->
    convert_to_csv_str(ret, obj.field) for obj in obj_arr
  tmp = [""]
  get_header_line(tmp,this.grid.getColumns())
  ret.push(tmp[0])
  max_row = this.grid.getDataLength()
  get_data_line = (ret, obj_arr) ->
    tmp = [""]
    convert_to_csv_str(tmp, obj_arr[col.field]) for col in this.grid.getColumns()
    ret.push(tmp[0])
  get_data_line(ret, this.grid.getDataItem(i)) for i in [0..max_row-1]
  ret.join("\n")

@get_yaml_content = () ->
  ret = []
  max_row = this.grid.getDataLength()
  write_each_date = (ret, obj_arr, col) ->
    ret.push("  #{col.field}: #{obj_arr[col.field]}") unless col.field=="id"
  write_row = (ret, obj_arr) ->
    ret.push("- id: #{obj_arr['id']}")
    write_each_date ret, obj_arr, col for col in this.grid.getColumns()
    ret.push("")
  write_row(ret, this.grid.getDataItem(i)) for i in [0..max_row-1]
  ret.join("\n")

  