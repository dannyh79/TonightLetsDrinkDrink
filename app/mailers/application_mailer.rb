# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'do-not-reply@tonightletsdrinkdrink.tw'
  layout 'mailer'
end
