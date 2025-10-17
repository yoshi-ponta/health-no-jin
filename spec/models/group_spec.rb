require "rails_helper"

RSpec.describe Group, type: :model do
  subject(:group) { described_class.new }

  before do
    allow(group).to receive(:stage_limits).and_return([ 0, 50, 150, 300 ])
  end

  def percent(total)
    allow(group).to receive(:total_points).and_return(total)
    group.progress_percent
  end

  it "区間の開始点に来たら進捗が0%にリセットされる" do
    expect(percent(50)).to  eq 0
    expect(percent(150)).to eq 0
  end

  it "最終区間では進捗が常に100%になる" do
    expect(percent(300)).to  eq 100
    expect(percent(1000)).to eq 100
  end
end
