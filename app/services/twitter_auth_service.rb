class TwitterAuthService
  class << self
    def register(auth_hash, cookies)
      attrs = user_attrs(auth_hash)
      authorization = Authorization.where(provider: auth_hash[:provider], uid: auth_hash[:uid])
                                   .first_or_initialize

      if authorization.persisted?
        user = authorization.user
      else
        user = UserTwitterType.where(twitter_name: attrs[:twitter_name]).first_or_create(attrs)
        user.authorizations << authorization

        user.show_as_participant = true
        user.save
      end

      if user.new?
        user.activate!
        GoogleAnalyticsClient.register_event(user, cookies)
      end

      user
    end

    private
    def user_attrs(auth_hash)
      name = auth_hash[:info][:name].split
      twitter_info = {
        first_name: name.first,
        last_name: name.last,
        photo: auth_hash[:info][:image],
        twitter_name: auth_hash[:info][:nickname]
      }

      ActionController::Parameters.new twitter_info
    end
  end
end
