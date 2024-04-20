require 'rails_helper'

RSpec.describe User, type: :model do
  subject {User.new(name:"Amar",email:"madhekaramar@13.com",password:"Amar@123",contact:"9834961559",role:"ADMIN",address:"141 Karvenagar",city_id:1)}

  it "is valid with valid attributes"do
    expect(subject).to be_valid
  end
  
  it "is not valid without name"do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid without contact number" do
    subject.contact = nil
    expect(subject).to_not be_valid
  end


end
