require "spec_helper"

describe "be_able_to", focus: true do
  it "delegates to can?" do
    expect(object = double).to receive(:can?).with(:read, 123) { true }
    expect(object).to be_able_to(:read, 123)
  end

  it "delegates to can? with array of abilities" do
    expect(object = double).to receive(:can?).with(:read, 123) { true }
    expect(object).to receive(:can?).with(:update, 123) { true }
    expect(object).to be_able_to([:read, :update], 123)
  end

  it "reports a nice failure message for should" do
    expect(object = double).to receive(:can?).with(:read, 123) { false }
    expect {
      expect(object).to be_able_to(:read, 123)
    }.to raise_error('expected to be able to :read 123')
  end

  it "reports a nice failure message for should not" do
    expect(object = double).to receive(:can?).with(:read, 123) { true }
    expect {
      expect(object).to_not be_able_to(:read, 123)
    }.to raise_error('expected not to be able to :read 123')
  end

  it "delegates additional arguments to can? and reports in failure message" do
    expect(object = double).to receive(:can?).with(:read, 123, 456) { false }
    expect {
      expect(object).to be_able_to(:read, 123, 456)
    }.to raise_error('expected to be able to :read 123 456')
  end
end
