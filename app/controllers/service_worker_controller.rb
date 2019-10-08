# frozen_string_literal: true

class ServiceWorkerController < ApplicationController
  protect_from_forgery except: :service_worker
  def manifest; end

  def service_worker; end
end
