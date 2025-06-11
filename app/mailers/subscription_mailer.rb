class SubscriptionMailer < ApplicationMailer
    def subscribe(user, signed_url_resume, signed_url_transcript1 = nil, signed_url_transcript2 = nil)
        @user = user
        @signed_url_resume = signed_url_resume
        @signed_url_transcript1 = signed_url_transcript1
        @signed_url_transcript2 = signed_url_transcript2
        mail(to: @user.email, subject: "Here's Yihe's Resume")
    end

    def unsubscribe
        mail(to: @user.email, subject: 'Unsubscription Confirmation')
    end
end
