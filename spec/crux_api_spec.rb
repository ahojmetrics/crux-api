# frozen_string_literal: true

RSpec.describe CruxApi do
  it "has a version number" do
    expect(CruxApi::VERSION).not_to be nil
  end
end
