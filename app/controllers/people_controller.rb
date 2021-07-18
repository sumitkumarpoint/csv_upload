# This Class will work in creation on people from csv file
# or from failed record
class PeopleController < ApplicationController
  # GET /people will return an array of people.
  def index
    people = Person.all
    render json: people, status: :ok
  end

  # POST /people or /people.json
  # if block will work csv file upload and
  # else will work for creating person
  # if there is any validation error in any
  # record after uploading csv file.
  def create
    if params['csv_file'].present?
      require 'csv'
      params[:people] = []
      csv_text = File.read(params['csv_file'].path)
      csv      = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        params[:people] << row.to_hash
      end
      people = Person.create(people_params[:people])
      render json: people.as_json(methods: :error_messages), status: :ok
    elsif params['person'].present?
      person = Person.new(person_params)
      if person.save
        render json: person.as_json(methods: :error_messages), status: :ok
      else
        render json: { errors: person.error_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'CSV file not found.' }, status: :not_found and return
    end
  end

  private

  # Only allow a list of trusted parameters through for person.
  def person_params
    params.require(:person).permit(:first_name, :last_name, :email, :phone)
  end

  # Only allow a list of trusted parameters through for people.
  def people_params
    params.permit(people: [:first_name, :last_name, :email, :phone])
  end
end
