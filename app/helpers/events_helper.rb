module EventsHelper
  def french_date_format(event)
    I18n.l(event.start_date, format: :evenement)
  end

  def min_to_hour(minutes)
    minutes = minutes.to_i
       if minutes < 60
      "#{minutes} min"
       else
    hours = minutes / 60
    minutes_remain = minutes % 60
    formated_minutes = minutes_remain.to_s.rjust(2, "0")
    "#{hours}h#{formated_minutes}"
       end
  end

  def price_cents (price)
    price = price * 100
  end
end
