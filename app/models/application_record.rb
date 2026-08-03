# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ## [DN] We've forced usage of UUIDs as the primary key so default ordering
  ## won't work well. The following line can be enabled to make all models use
  ## `created_at` by default. However, if a specific model opts to skip having
  ## timestamp attributes, then you will need to override it for that model.
  ## You can also copy this line into a single model if you infrequently need it
  ## but you should probably index `created_at` if you do this though.
  # self.implicit_order_column = 'created_at'
end
