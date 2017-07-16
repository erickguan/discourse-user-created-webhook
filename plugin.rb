# name: discourse-user-created-webhook
# version: 1.0
# authors: Erick Guan (fantasticfears@gmail.com)

PLUGIN_NAME = 'discourse_user_created_webhook'.freeze

enabled_site_setting :discourse_user_created_webhook_enabled

after_initialize do
  register_seedfu_fixtures(Rails.root.join("plugins", "discourse-user-created-webhook", "db", "fixtures").to_s)

  DiscourseEvent.on(:user_created) do |user|
    WebHook.enqueue_hooks(:user, user_id: user.id, event_name: 'user_created')
  end

end
