class UserMailer < ActionMailer::Base
  def welcome_email(user)
    recipients user.email
    from "<zhuzheiswho@gmail.com>"
    subject "welcome"
    body({:user=>user,:url=>"http://localhost:3000/session/new"})
    sent_on Time.now
    content_type "text/html"
  end

end
