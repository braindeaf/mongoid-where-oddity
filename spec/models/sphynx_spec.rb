require 'rails_helper'

RSpec.describe Sphynx do
  let!(:lazy) { create(:sphynx, lazy: true) }
  let!(:active) { create(:sphynx, lazy: false) }

  it 'has a default scope' do
    expect(described_class.all).to include(lazy)
    expect(described_class.all).not_to include(active)
  end

  it 'has default scope in selector' do
    expect(described_class.all.selector).to eq('lazy' => true)
  end
end
