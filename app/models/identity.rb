# frozen_string_literal: true

class Identity < ApplicationRecord
  belongs_to :user

  validates_presence_of   :provider
  validates_presence_of   :uid
  validates_uniqueness_of :uid, scope: :provider

  # FIXME: method name
  def self.find_for_auth(auth)
    find_or_create_by uid: auth.uid, provider: auth.provider
  end
end
