require 'rails_helper'

RSpec.describe DataGouvService do
  describe '.fetch_data' do
    context 'when API request is successful' do
      let(:successful_response) {
        instance_double(
          'Net::HTTPSuccess',
          :is_a? => true,
          :body => {
            'records' => [{
              'fields' => {
                'siret' => '12345678901234',
                'rs' => 'Test Etablissement',
                'numvoie' => '123',
                'typvoie' => 'rue',
                'voie' => 'de la Test',
                'ligneacheminement' => '75000 Paris',
                'telephone' => '0123456789',
                'datemaj' => '2023-10-01',
                'lat' => '48.8566',
                'lon' => '2.3522',
                'libmft' => 'Active',
              }
            }]
          }.to_json
        )
      }

      before do
        allow(Net::HTTP).to receive(:get_response).and_return(successful_response)
      end

      it 'creates a new Etablissement' do
        expect { described_class.fetch_data }.to change(Etablissement, :count).by(1)
      end
    end

    context 'when API request is unsuccessful' do
      let(:unsuccessful_response) {
        instance_double(
          'Net::HTTPClientError',
          :is_a? => false,
          :code => '400',
          :message => 'Bad Request'
        )
      }

      before do
        allow(Net::HTTP).to receive(:get_response).and_return(unsuccessful_response)
      end

      it 'does not create a new Etablissement' do
        expect { described_class.fetch_data }.not_to change(Etablissement, :count)
      end

      it 'outputs an error message' do
        allow(Rails.logger).to receive(:error)
        expect(Rails.logger).to receive(:error).with('Error: 400 - Bad Request')
        described_class.fetch_data
      end
    end
  end
end
