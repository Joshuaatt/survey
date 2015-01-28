require 'spec_helper'

describe Survey do
  it "capitalizes the survey name string" do
    test_survey = Survey.create({ name: "survey" })
    expect(test_survey.name).to eq "Survey"
  end
end
