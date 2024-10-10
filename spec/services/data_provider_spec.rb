require 'rails_helper'

RSpec.describe DataProvider do
  describe '#call' do
    it 'raises an error for invalid query' do
      allow(RegexMatchers).to receive(:domain_match).and_return(false)
      allow(RegexMatchers).to receive(:ip_match).and_return(false)

      expect { described_class.new(api_client: "random_api_client").call('random_query') }
        .to raise_error(CustomErrors::QueryValidationError)
    end
  end
end
