module ApplicationHelper
  include SessionsHelper

  def unfrozen_time(time)
    clone = time.to_s.dup if time.to_s.frozen?
    clone.gsub!(/UTC/, "")
  end

  def breadcrumb_category_root?(category_id, cat_id)
    true if category_id == cat_id
  end

end
