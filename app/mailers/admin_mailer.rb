class AdminMailer < ActionMailer::Base
  default from: "hmm@hipay.me"
  ADMIN_EMAIL = "admin_alert@hipay.me"

  def new_record_alert(record)
    @record = record
    @resource_name = record.class.name.downcase
    mail :to => ADMIN_EMAIL, :subject => "[Alert] New #{@resource_name} created"
  end
end
