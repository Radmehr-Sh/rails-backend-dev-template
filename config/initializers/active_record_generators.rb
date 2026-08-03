# frozen_string_literal: true

## [DN] Make `rails generate` use UUID by default
Rails.application.config.generators do |generator|
  generator.orm :active_record, primary_key_type: :uuid
end
