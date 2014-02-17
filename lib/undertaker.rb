require "undertaker/version"
require "active_support/logger"

module Undertaker

  def self.new(*args)
    Undertaker.new(*args)
  end

  class Undertaker
    attr_accessor :attempts
    attr_reader :limit

    def initialize(options = {})
      @attempts = 0
      @limit = options[:limit] || 10
      @logger = options[:logger] || ActiveSupport::Logger.new(STDOUT)
    end

    def execute &block
      self.attempts += 1
      yield
    rescue StandardError => exception
      if should_retry?
        log_retry exception
        sleep delay
        retry
      end
      raise e
    end

    private

    def should_retry?
      attempts < limit
    end

    def delay
      (1.0 / 2.0 * (2.0**attempts - 1.0)).ceil
    end

    def log_retry(exception)
      @logger.warn "Undertaker: #{exception} raised retring..."
      @logger.warn exception.backtrace[0..5].join("\n")
    end
  end
end
