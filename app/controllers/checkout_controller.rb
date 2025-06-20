class CheckoutController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    customer = Stripe::Customer.create(
      email: current_user.email,
      name: current_user.fullname
    )
    session = Stripe::Checkout::Session.create({
      payment_method_types: [ "card" ],
      customer: customer.id,
      line_items: [ {
        price_data: {
          currency: "eur",
          product_data: { name: event.title },
          unit_amount: price_cents(event.price)
        },
        quantity: 1
      } ],
      mode: "payment",
      client_reference_id: "#{current_user.id}-#{event.id}",

      success_url: payment_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: event_url(event) + "?canceled=true"
    })
    redirect_to session.url, allow_other_host: true
  end

  private

  def price_cents(price)
    (price * 100).to_i
  end
end
