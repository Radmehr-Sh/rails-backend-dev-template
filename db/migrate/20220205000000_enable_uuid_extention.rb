# frozen_string_literal: true

class EnableUuidExtention < ActiveRecord::Migration[7.0]
  ## [DN] This Postgres extension allows us to make primary keys use UUIDs
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
  end
end
