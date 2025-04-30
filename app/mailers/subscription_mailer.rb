class SubscriptionMailer < ApplicationMailer
    def subscribe(user, signed_url)
        @user = user
        @signed_url = signed_url
        mail(to: @user.email, subject: "Subscription Confirmation")
    end
    def unsubscribe
        mail(to: @user.email, subject: 'Unsubscription Confirmation')
    end
end
