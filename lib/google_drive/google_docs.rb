=begin

module GoogleDrive

  class GoogleDocs

    attr_writer :client_id, :client_secret, :redirect_uri

    def initialize(client_id, client_secret, redirect_uri)
      @client_id = '762233476420.apps.googleusercontent.com'
      @client_secret = 'bedsgR2PJGe6cLkLttEiRtgH'
      @redirect_uri = 'http://localhost:3000/oauth2callback'
    end

    def create_google_client
      OAuth2::Client.new(
        @client_id, @client_secret,
        :site => "https://accounts.google.com",
        :token_url => "/o/oauth2/token",
        :authorize_url => "/o/oauth2/auth")
    end

    def set_google_authorize_url
      client = create_google_client
      client.auth_code.authorize_url(
        :redirect_uri => @redirect_uri,
        :access_type => "offline",
        :scope =>
          "https://docs.google.com/feeds/ " +
          "https://docs.googleusercontent.com/ " +
          "https://spreadsheets.google.com/feeds/")
    end

  end
end

=end