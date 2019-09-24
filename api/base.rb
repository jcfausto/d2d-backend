# frozen_string_literal: true

module API
  # Base API where each individual API can be mounted
  class Base < Grape::API
    mount APIv1::Root
  end
end
