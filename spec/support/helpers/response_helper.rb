# frozen_string_literal: true

module ResponseHelper
  # The response always has stringified keys in the parsed_body since it's JSON
  def indifferent_body(response)
    response&.parsed_body&.with_indifferent_access
  end
end
