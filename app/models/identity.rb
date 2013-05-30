class Identity < OmniAuth::Identity::Models::ActiveRecord
attr_accessible :email, :name, :password_digest :password, :password confirmation
end