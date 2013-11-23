module Paging

  def is_last_page?
    current_page + 1 > page_range.last
  end

  def page_range
    1..number_of_pages
  end

  def number_of_pages
    (total_days % 7 > 0) ? (total_days / 7 ) + 1 : (total_days / 7)
  end

  def is_first_page?
    current_page == 1
  end

  def next_page
    current_page + 1
  end

  def prev_page
    current_page - 1
  end

  def current_page
    params.fetch(:page, 1).to_i
  end

  def date_range (page = current_page)
    (page_start_date(page) .. page_end_date(page) )
  end

  def paged_week
    page_start_date .. page_end_date
  end

  def first_unplanned_week
    last_page .. last_page + 7.days
  end

  private

  def page_start_date(page = current_page)
    (Time.now + ( 7 * (page - 1)).days).to_date
  end

  def page_end_date(page = current_page)
    (Time.now + ( 7 * (page )).days).to_date
  end

  def last_page
    @last_date ||= Meal.order(:day).last.day
  end

  def first_page
    Time.now.to_date
  end

  def total_days
    last_page - first_page
  end

end