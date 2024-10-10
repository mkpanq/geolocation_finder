require 'rails_helper'

RSpec.describe ApiClients::IpApi do
  let(:wrong_query) { 'wrong_query' }
  let(:proper_query) { 'wp.pl' }
  let(:success_data) {
    {
      "query": "wp.pl",
      "ip": "212.77.98.9",
      "domain": "www.wp.pl",
      "continent": "Europe",
      "country": "Poland",
      "country_code": "PL",
      "region": "Mazovia",
      "region_code": "14",
      "city": "Warsaw",
      "zip": "00-510",
      "timezone": "Europe/Warsaw",
      "lattitude": 52.2297,
      "longitude": 21.0122,
      "isp_name": "Wirtualna Polska Media S.A.",
      "org_name": "Wirtualna Polska SA"
    }
  }

  describe '#call' do
    context 'when the API returns success data', vcr: { cassette_name: "ip_api_success_response" } do
      it 'returns data from the API' do
          result = described_class.call(proper_query)
          expect(result).to match(a_hash_including(success_data))
      end
    end

    context 'when the API returns fail data', vcr: { cassette_name: "ip_api_failed_response" }  do
      it 'raise CustomErrors::NotFoundError' do
        expect { described_class.call(wrong_query) }.to raise_error(CustomErrors::NotFoundError)
      end
    end

    context 'when faraday raises errors', vcr: { cassette_name: "faraday_errors" } do
      after { Faraday.default_connection = nil }

      let(:stubs) { Faraday::Adapter::Test::Stubs.new }
      let(:client) { Faraday.new { |b| b.adapter(:test, stubs) } }

      context 'when too many requests error' do
        it 'raise CustomErrors::TooManyRequestsError' do
          stubs.get('toomuch') { raise Faraday::TooManyRequestsError }

          allow(described_class).to receive(:generateFaradayClient).and_return(client)
          expect { described_class.call('toomuch') }.to raise_error(CustomErrors::TooManyRequestsError)

          stubs.verify_stubbed_calls
        end
      end

      context 'when other error' do
        it 'raise CustomErrors::ServerError' do
          stubs.get('thatsnotgonnawork') { raise Faraday::Error }

          allow(described_class).to receive(:generateFaradayClient).and_return(client)
          expect { described_class.call('thatsnotgonnawork') }.to raise_error(CustomErrors::ServerError)

          stubs.verify_stubbed_calls
        end
      end
    end
  end
end
