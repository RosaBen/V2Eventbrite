class PaymentsController < ApplicationController
  def success
    session_id = params[:session_id]
    stripe_session = Stripe::Checkout::Session.retrieve(session_id)
  
    stripe_customer_id = stripe_session.customer
    event_id = stripe_session.client_reference_id.split("-").last
    event = Event.find(event_id)
  
    Attendance.find_or_create_by!(
      user: current_user,
      event: event,
      stripe_customer_id: stripe_customer_id
    )
  
    redirect_to event_path(event), notice: "✅ Paiement réussi et inscription enregistrée."
  end
  
end
