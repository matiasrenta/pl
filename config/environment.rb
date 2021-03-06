# Load the rails application
require File.expand_path('../application', __FILE__)

QUALTOP = false
APP_INSTANCE = Rails.root.to_s.split("/").last

case APP_INSTANCE
  when "pl" then
    HOST = "printland.matsoft.railsplayground.net"
    LOGO = "logo_printland.gif"
    NOREPLY_MAIL = "noreply@printland.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Printland" <noreply@printland.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
  when "printland" then
    HOST = "printland.matsoft.railsplayground.net"
    LOGO = "logo_printland.gif"
    NOREPLY_MAIL = "noreply@printland.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Printland" <noreply@printland.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
  when "sye" then
    HOST = "sye.matsoft.railsplayground.net"
    LOGO = "logo_sye.png"
    NOREPLY_MAIL = "noreply@sye.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Gudplan" <noreply@sye.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
  when "3mb" then
    HOST = "3mb.matsoft.railsplayground.net"
    LOGO = "logo_3mb.png"
    NOREPLY_MAIL = "noreply@3mb.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Gudplan" <noreply@3mb.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
  when "qualtop" then
    QUALTOP = true
    HOST = "qualtop.matsoft.railsplayground.net"
    LOGO = "logo_gudplan.png"
    NOREPLY_MAIL = "noreply@gudplan.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Gudplan" <noreply@gudplan.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
  when "gudplan" then
    HOST = "gudplan.matsoft.railsplayground.net"
    LOGO = "logo_gudplan.png"
    NOREPLY_MAIL = "noreply@gudplan.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Gudplan" <noreply@gudplan.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
=begin
  when "projector" then
    HOST = "localhost:3000"
    LOGO = "logo_gudplan.png"
    NOREPLY_MAIL = "noreply@gudplan.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Gudplan" <noreply@gudplan.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
=end
  else
    HOST = "localhost:3000"
    LOGO = "logo_printland.gif"
    NOREPLY_MAIL = "noreply@printland.matsoft.railsplayground.net"
    NOREPLY_FRIENDLY = %{"Printland" <noreply@printland.matsoft.railsplayground.net>}
    NOREPLY_PASS = "misterio"
end



# Initialize the rails application
Pru1::Application.initialize!

# Apply patch for date and date input
#require 'lib/column_patch'
#ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!(default => '%d/%m/%Y')
#ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!(default => '%d/%m/%Y %H:%M')

ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
