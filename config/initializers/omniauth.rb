OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '287289154633208', '857a2e1a8b1b8c947604c14ad659338a'
end
