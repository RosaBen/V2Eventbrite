# Views bootstrap code

<!-- ----------------------------------------------------------- -->

## _header.html.erb
```ruby

        <nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm">
            <div class="container-fluid"><%= link_to "🗞️ events", events_path, class: "navbar-brand fw-bold" %>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">

                        <% if user_signed_in? %>

                        <li class="nav-item">
                            <%= button_to "Se déconnecter",
                            destroy_user_session_path, 
        method: :delete, data: { confirm: "Es-tu sûr(e) ?" }, 
        class: "btn btn-outline-danger" %>
                        </li>
                        <li class="nav-item"><%= link_to "Mon profil",
                        user_path(current_user),
                        class: "nav-link text-white" %></li>
                        <li class="nav-item"><%= link_to "Tous les evenements", 
                        events_path, 
                        class: "nav-link text-white" %></li>
  <li class="nav-item dropdown">
    <a class="nav-link dropdown-toggle" href="#" id="eventsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
      liste des participants
    </a>
    <ul class="dropdown-menu" aria-labelledby="eventsDropdown">
            <% current_user.created_events.each do |event| %>
              <li>
                <%= link_to event.title, guests_event_path(event), class: "dropdown-item" %>
              </li>
            <% end %>
          </ul>
        </li>
        <% else %>
          <li class="nav-item">
            <%= link_to "Se connecter", 
            new_user_session_path,
            class: "nav-link text-white" %>
          </li>
          <li class="nav-item">
            <%= link_to "S'inscrire", 
            new_user_registration_path, 
            class: "nav-link text-white" %>
          </li>
        <% end %>
        <li class="nav-item"><%= link_to "Accueil", root_path, class: "nav-link text-white" %></li>
      </ul>
      </div>
      </div>
      </nav>
  
```