require 'pry'
require 'benchmark'
require 'undertaker'

describe Undertaker, 'configuration' do

  it 'allows the limit and logger to be configured' do
    undertaker = Undertaker.new(limit: 1, logger: "Logger")

    expect(undertaker.instance_variable_get(:@limit)).to eq 1
    expect(undertaker.instance_variable_get(:@logger)).to eq "Logger"
  end
end

describe Undertaker, '#execute' do
  it 'executes a block' do
    x = 5

    Undertaker.new.execute do
      x = 10
    end

    expect(x).to be 10
  end

  it 'retries on failure until the limit is hit' do
    test_attempts = 0

    expect do
      Undertaker.new(limit: 3).execute do
        test_attempts += 1
        raise NameError
      end
    end.to raise_error(NameError)

    expect(test_attempts).to eq 3
  end

  it 'backs off exponentially on failure' do
    duration = Benchmark.measure do
      begin
        Undertaker.new(limit: 3).execute do
          raise StandardError
        end
      rescue StandardError => e
      end
    end
    expect(duration.real).to be >= 2
  end
end
