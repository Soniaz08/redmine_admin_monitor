Redmine::Plugin.register :redmine_admin_monitor do
  name 'Redmine Admin Errors and Exceptions Monitor plugin'
  author 'forked from Yoss!E <4yossiedri@gmail.com>'
  description 'This Plugin provides an automatic error monitoring and reporting.'
  version '1.0.0'
  url 'https://github.com/Soniaz08/redmine_admin_monitor'

  menu :top_menu, :admin_monitor, { :controller => :admin_monitor_alerts, :action => 'index',:conditions => 'false' },
    :caption => :admin_monitor ,
    :if => Proc.new { User.current.admin? }

  settings  :default => {:default_project_id => "1",:default_tracker_id => "1"} , :partial => "settings/admin_monitor_settings"  

  end

  Rails.application.config.to_prepare do

  unless ApplicationController.included_modules.include?(RedmineAdminMonitor::Patches::ApplicationControllerPatch)
    ApplicationController.send(:include,RedmineAdminMonitor::Patches::ApplicationControllerPatch)
  end

  unless ApplicationController.included_modules.include?(RedmineAdminMonitor::Patches::MailerPatch)
    Mailer.send(:include,RedmineAdminMonitor::Patches::MailerPatch)
  end

 end
