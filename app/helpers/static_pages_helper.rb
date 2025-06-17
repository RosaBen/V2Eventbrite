module StaticPagesHelper
  def events_post_it
    @events = Event.order("RANDOM()").limit(5)
    @events.each_with_index.map do |event, index|
      {
        event: event.title,
        description: event.description,
        date: event.start_date.strftime("%B %d, %Y"),
        color: [ "#fffd82", "#ffc9de", "#c9f2ff", "#d1ffc9", "#ffe0ac" ].sample,
        rotation: [ -5, 3, -2, 4, -4 ].sample,
        top: index * 40,
        left: 50,
        z: 10 - index
      }
    end
  end

  def render_post_its
    events_post_it.each_with_index.map do |data, i|
      content_tag(:div,
        style: "width: 200px;
                background-color: #{data[:color]};
                transform: rotate(#{data[:rotation]}deg);
                top: #{data[:top]}px;
                left: #{data[:left]}px;
                z-index: #{data[:z]};
                border: 1px solid #ccc;
                border-radius: 10px;",
        class: "postit-card shadow position-absolute p-3") do
          content_tag(:h5, truncate(data[:event], length: 25), class: "fw-bold") +
          content_tag(:p, truncate(data[:event], length: 100), class: "small") +
          content_tag(:p, data[:event], class: "text-muted small") +
          link_to("Lire", Rails.application.routes.url_helpers.event_path(data[:event]), class: "btn btn-sm btn-outline-dark")
      end
    end.join.html_safe
  end
end
