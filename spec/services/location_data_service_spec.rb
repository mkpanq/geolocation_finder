require 'rails_helper'

RSpec.describe LocationDataService do
  before(:example) { GeoLocation.create!(query: 'example.com', ip: '123.123.123.123', domain: 'aws-domain.server.com') }

  describe '#get_geological_data' do
    let (:result_hash) { { "query" => 'example.com', "ip" => '123.123.123.123', "domain" => 'aws-domain.server.com' } }

    it 'returns data for existing query' do
      result_by_query = described_class.new.get_geological_data('example.com').attributes
      expect(result_by_query).to include(result_hash)

      result_by_ip = described_class.new.get_geological_data('123.123.123.123').attributes
      expect(result_by_ip).to include(result_hash)

      result_by_domain = described_class.new.get_geological_data('aws-domain.server.com').attributes
      expect(result_by_domain).to include(result_hash)
    end

    it 'raises an error for non-existing query' do
      expect { described_class.new.get_geological_data('non-existing.com') }.to raise_error(CustomErrors::NotFoundError)
    end
  end

  describe '#delete_geological_data' do
    it 'removes data for deletion query' do
      expect { described_class.new.delete_geological_data('example.com') }.to change { GeoLocation.count }.by(-1)
    end

    it 'returns data for removing query' do
      result = described_class.new.delete_geological_data('example.com').attributes
      expect(result).to include("query" => 'example.com', "ip" => '123.123.123.123', "domain" => 'aws-domain.server.com')
    end

    it 'raises an error for non-existing query' do
      expect { described_class.new.get_geological_data('non-existing.com') }.to raise_error(CustomErrors::NotFoundError)
    end
  end

  describe '#add_geological_data' do
    context "with refresh false" do
      it "raises an error if location exists" do
        expect { described_class.new.add_geological_data('example.com') }.to raise_error(CustomErrors::DataAlreadyExistsError)
      end

      it "saves data if location does not exist", vcr: { cassette_name: "ip_api_success_response" } do
        expect { described_class.new.add_geological_data('wp.pl') }.to change { GeoLocation.count }.by(1)
      end
    end

    context "with refresh true" do
      it "updates existing record with new data", vcr: { cassette_name: "update_record_success_response" } do
        expect { described_class.new.add_geological_data('example.com', true) }
        .to change { GeoLocation.find_by(query: 'example.com').updated_at }
        .and change { GeoLocation.find_by(query: 'example.com').ip }
      end

      it "saves data if location does not exist", vcr: { cassette_name: "ip_api_success_response" } do
        expect { described_class.new.add_geological_data('wp.pl') }.to change { GeoLocation.count }.by(1)
      end
    end
  end
end
