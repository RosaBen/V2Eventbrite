module EventsHelper
  def french_date_format(event)
    I18n.l(event.start_date, format: :evenement)
  end
end
