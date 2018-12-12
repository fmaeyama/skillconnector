module OfficeHelper
  def helper_office_longname_html(office)
    concat tag.span(office.cd,class:"sl-content")
    concat tag.span( "#{office.long_name}(#{office.location_short})", class:"sl-content")
  end

end
