require "undertaker/version"
require "active_support/logger"

module Undertaker

  def self.new(*args)
    Undertaker.new(*args)
  end

  class Undertaker
    attr_accessor :attempts, :retry_condition
    attr_reader :limit

    def initialize(options = {})
      @exceptions = []
      @attempts = 0
      @limit = options[:limit] || 10
      @logger = options[:logger] || ActiveSupport::Logger.new(STDOUT)
    end

    def execute
      setup_execution
      yield
    rescue StandardError => exception
      add_exception exception
      if should_retry?
        setup_retry
        retry
      end
      raise exception
    end

    def retry_when(&block)
      self.retry_condition = block
    end

    private

    def setup_execution
      self.attempts += 1
    end

    def setup_retry
      log_retry
      sleep exponential_backoff
    end

    def add_exception(exception)
      @exceptions << exception
    end

    def last_exception
      @exceptions.last
    end

    def should_retry?
      attempts < limit && retry_condition?
    end

    def retry_condition?
      retry_condition.nil? || retry_condition.call(last_exception)
    end

    def exponential_backoff
      (1.0 / 2.0 * (2.0**attempts - 1.0)).ceil
    end

    def log_retry
      @logger.warn "Undertaker: #{last_exception} raised retring..."
      @logger.warn last_exception.backtrace[0..5].join("\n")
    end
  end
end
