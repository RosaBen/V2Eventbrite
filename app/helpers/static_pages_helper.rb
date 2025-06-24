module StaticPagesHelper
  def events_post_it(events)
    colors = [ "#fffd82", "#ffc9de", "#c9f2ff", "#d1ffc9", "#ffe0ac" ]
    rotations = [ -5, 3, -2, 4, -4 ]

    events.each_with_index.map do |event, index|
      {
        event: event,
        title: event.title,
        description: event.description,
        date: event.start_date.strftime("%B %d, %Y"),
        color: colors.sample,
        rotation: rotations.sample,
        # top et left avec un écart plus grand et un peu aléatoire
        top: 100 + index * 80 + rand(-20..20),
        left: 100 + index * 120 + rand(-30..30),
        z: 5 - index
      }
    end
  end

  def render_post_its(events)
    events_post_it(events).map do |data|
      content_tag(:div,
        style: "width: 400px;
        padding: 20px;
                background-color: #{data[:color]};
                transform: rotate(#{data[:rotation]}deg);
                position: absolute;
                top: #{data[:top]}px;
                left: #{data[:left]}px;
                z-index: #{data[:z]};
                border: 1px solid #ccc;
                border-radius: 10px;",
        class: "postit-card shadow p-3") do
          content_tag(:h5, truncate(data[:title], length: 25), style: "font-weight: bold;") + tag(:hr, style: "border-top: 3px solid #ccc;") +
          content_tag(:p, truncate(data[:description], length: 100), style: "font-size: 14px; line-height: 1.5; padding-top: 10px;") +
          content_tag(:p, data[:date], style: "font-size: 12px; color: #666;") +
          link_to("Lire", Rails.application.routes.url_helpers.event_path(data[:event]), style: "display: inline-block; margin-top: 10px; padding: 5px 10px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px;")
      end
    end.join.html_safe
  end

  def fetch_nearest_events
    now = Date.today
    start_of_week = now.beginning_of_week(:monday)
    end_of_week = now.end_of_week(:sunday)
    current_week = Event.where(start_date: start_of_week..end_of_week)
    return [ current_week, "Événements de la semaine en cours 🗓️" ] if current_week.any?
    next_week = Event.where(start_date: (start_of_week + 7)..(end_of_week + 7))
    return [ next_week, "Événements de la semaine prochaine 🔮" ] if next_week.any?
    [ [], nil ]
  end
end
