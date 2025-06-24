class UserMailer < ApplicationMailer
  default from: "no-reply@monsite.fr"

  def welcome(user)
    @user = user
    @url  = "http://localhost:3000/login"
    mail(to: @user.email, subject: "Bienvenue sur EventBrite !")
  end

  def new_participant_email(attendance)
    @attendance = attendance
    @event = attendance.event
    @creator = @event.user
    @participant = attendance.user

    mail(to: @creator.email, subject: "Nouvelle inscription à ton événement : #{@event.title}")
  end
end
