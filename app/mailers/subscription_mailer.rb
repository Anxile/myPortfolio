class SubscriptionMailer < ApplicationMailer
    def subscribe(user, signed_url)
        @user = user
        @signed_url = signed_url
        mail(to: @user.email, subject: "Here's Yihe's Resume")
    end
    def unsubscribe
        mail(to: @user.email, subject: 'Unsubscription Confirmation')
    end
end
