require "paging"

module DatePagerHelper

  include Paging

  DEFAULT_OPTIONS = {
    prev: "< Prev Page",
    next: "Next Page >",
    count: 5, 
    show_next_prev: :conditional
  }.freeze

  def date_pager (options = {})

    options = DEFAULT_OPTIONS.merge(options)

    tags = []

    prev_text = options[:prev]
    next_text = options[:next]

    unless is_first_page? && options[:show_next_prev] != :always
      if block_given?
        prev_text = yield prev_text, url_for({page: prev_page}), :prev 
      else
        tags << link_to_unless_current(prev_text, url_for({page: prev_page}))
      end
    end

    optimal_range(page_range, options[:count], current_page).each do |n|
      tags << link_to_unless_current( n, url_for({page: n}))
      yield n, url_for({page: n}), "page-#{n}".to_sym if block_given?
    end

    unless is_last_page? && options[:show_next_prev] != :always
      if block_given?
        yield next_text, url_for({page: next_page}), :next
      else
        tags << link_to_unless_current(next_text, url_for({page: next_page}))
      end
    end

    tags.join("\n").html_safe

  end
  alias :old_date_range :date_range

  def date_range(n)
    range_pair = old_date_range(n).minmax
  end

  def optimal_range(range, subrange_size, center)
    return range if subrange_size === :all
    range = Range.new *((range).minmax.map &:to_i)
    subrange_size -= 1

    count_below = (subrange_size) / 2
    count_above = (subrange_size  - count_below)

    from = [ center - count_below, range.min].max
    to = [from + subrange_size, range.max].min
    from = [ to - subrange_size, range.min].max

    from .. to
  end

end