require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  describe 'GET /people (GET index)' do
    context 'When URL is correct' do
      it 'It will return list of people' do
        get :index, format: :json
        resp = JSON.parse(response.body)
        expect(resp).to be_instance_of Array
      end
    end
  end

  describe 'POST /people (CREATE people)' do
    context 'When csv file is there' do
      it 'It will create people' do
        post :create, params: { csv_file: fixture_file_upload('upload_address_sample.csv') }, format: :json
        resp = JSON.parse(response.body)
        expect(response.status).to eq 200
        expect(resp).to be_instance_of Array
      end
    end

    context 'When csv file is missing' do
      it 'It will return 404 as we are not sending csv file.' do
        post :create, params: { csv_file: '' }, format: :json
        resp = JSON.parse(response.body)
        expect(response.status).to eq 404
        expect(resp['message']).to eq 'CSV file not found.'
      end
    end
  end

  describe 'POST /people (CREATE person)' do
    context 'When all information is correct' do
      it 'It will create person' do
        post :create, params: {
          person: {
            first_name: 'abc',
            last_name: 'xyz',
            email: 'abc@xyz.com',
            phone: '+9392753254'
          }
        }, format: :json

        resp = JSON.parse(response.body)
        expect(response.status).to eq 200
        expect(resp['first_name']).to eq 'abc'
        expect(resp['last_name']).to eq 'xyz'
        expect(resp['email']).to eq 'abc@xyz.com'
        expect(resp['phone']).to eq '+9392753254'
      end
    end

    context 'When missing any required field data' do
      it 'It will return 422 as we are not passing last name' do
        post :create, params: {
          person: {
            first_name: 'abc',
            last_name: '',
            email: 'abc@xyz.com',
            phone: '+9392753254'
          }
        }, format: :json

        resp = JSON.parse(response.body)
        expect(response.status).to eq 422
        expect(resp['errors']['last_name'][0]).to eq 'Last Name is required.'
      end
    end
  end
end
