class User < ApplicationRecord
    validates :username, presence: { message: "Username can not be empty" }
    validates :username, uniqueness: { message: "The username already exists." }
    validates :password, presence: { message: "Password can not be empty" }
    validates :password, length: { minimum: 8, message: "Password has at least 8 digits" }
    validates :email, uniqueness: { message: "The email-address already exists." }

    has_many :toys
    has_many :public_toys, -> { where(is_public: true) },
      class_name: "toy"
    has_one :latest_toy,  -> { order("id desc") }, class_name: :toy

    # has_many :inboxes, class_name: :Message, foreign_key: :receiver_id
    # has_many :outboxes, class_name: :Message, foreign_key: :sender_id

    before_save :update_username

    #attr_accessor :old_password
    attr_accessor :password
    attr_accessor :password_confirmation

    validate :validate_password, on: :create
    before_create :set_password

    def self.authenticate username,password
      user=find_by(username: username)
      if user and user.valid_password?(password)
        user
      else
        nil
      end
    end

    def valid_password? password
      self.crypted_password == Digest::SHA256.hexdigest(password+self.salt)
    end

    attr_accessor :email
    validate :emali_format, on: :create
    
    private
    def update_username
      self.username = self.username.downcase
    end
    
    def validate_password
      if self.password.blank?
        self.errors.add(:password,"Password can not be empty")
        return false
      end

      def emali_format
        unless self.email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
          self.errors.add(:email,"Incorrect email-address")
          return false
        end
      end

      unless self.password == self.password_confirmation
        self.errors.add(:password_confirmation,"The passwords do not match.")
        return false
      end

      return true
    end

    def set_password
      self.salt = Time.now.to_i #其实不推荐用时间戳
      self.crypted_password = Digest::SHA256.hexdigest(self.password+self.salt)
    end


end
