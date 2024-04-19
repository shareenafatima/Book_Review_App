module BooksHelper
  def book_author(book)
    user_signed_in? && current_user.id == book.user_id
  end

  def average_rating_stars(average_rating)
    return '' if average_rating.nil?

    rounded_rating = average_rating.round
    full_stars = rounded_rating
    half_star = (average_rating - rounded_rating).abs >= 0.5 ? 1 : 0
    empty_stars = 5 - full_stars - half_star

    star_html = ''
    full_stars.times { star_html += fa_icon('star') }
    star_html += fa_icon('star-half-alt') if half_star == 1
    empty_stars.times { star_html += fa_icon('star-o') }

    star_html.html_safe
  end
end
