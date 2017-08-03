require "rails_helper"

describe "csv:import" do
  include_context "rake"

  let(:file) { Roo::CSV.new("spec/fixtures/people.csv") }

  before do
    User.stub(:import_users)
  end

  it "generates a registrations report" do
    expect(User).to receive(:import_users)
    subject.invoke
  end
end
