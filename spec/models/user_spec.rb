require "rails_helper"

RSpec.describe User, :type => :model do
  describe "Methods" do
    describe ".import_users" do

      context 'when email is blank' do
        let(:file) {Roo::CSV.new("spec/fixtures/withoutEmail.csv") }
        it 'does not import row' do
          expect(User).to receive(:puts).with("0 rows imported")
          User.import_users(file)
        end
      end

      context 'when name is blank' do
        let(:file) {Roo::CSV.new("spec/fixtures/withoutName.csv") }
        it 'does not import row' do
          expect(User).to receive(:puts).with("0 rows imported")
          User.import_users(file)
        end
      end

      context 'when only header row is present' do
        let(:file) {Roo::CSV.new("spec/fixtures/blankFileWithHeader.csv") }
        it 'does not import row' do
          expect(User).to receive(:puts).with("0 rows imported")
          User.import_users(file)
        end
      end

      context 'When file is having correct data' do
        let(:file) {Roo::CSV.new("spec/fixtures/people.csv") }
        it 'import rows into database' do
          expect(User).to receive(:puts).with("8 rows imported")
          User.import_users(file)
        end
      end

      context 'When file is having duplicate email address' do
        let(:file) {Roo::CSV.new("spec/fixtures/people.csv") }
        it 'import rows into database' do
          expect_any_instance_of(User).to receive(:update_attributes)
          User.import_users(file)
        end
      end
    end
  end
end