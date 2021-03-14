# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.
require 'nanoc/cachebuster'

include Nanoc::Helpers::CacheBusting
include Nanoc3::Helpers::LinkTo
include Nanoc3::Helpers::Blogging

module PostHelper
  def get_pretty_date(post)
    attribute_to_time(post[:created_at]).strftime('%B %-d, %Y')
  end
end
include PostHelper

module WeekNotes
def get_weeknumber()
    Time.now.strftime("%U")
  end
end
include WeekNotes