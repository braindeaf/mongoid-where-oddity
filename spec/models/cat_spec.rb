require 'rails_helper'

RSpec.describe Cat do
  let!(:lazy) { create(:cat, lazy: true) }
  let!(:active) { create(:cat, lazy: false) }

  it 'has a default scope' do
    expect(described_class.all).to include(lazy)
    expect(described_class.all).not_to include(active)
  end

  it 'has default scope in selector' do
    expect(described_class.all.selector).to eq('lazy' => true)
  end

  it 'probably shouldnt duplicate selectors' do
    expect(described_class.all.where(lazy: true).selector).to eq('lazy' => true)
  end

  it 'probably shouldnt duplicate selectors' do
    # it totally does though
    expect(described_class.all.where(lazy: true).selector).to eq('lazy' => true)
  end

  it 'probably should duplicate selectors consistently' do
    # it never duplicates the $and, it replaces it
    expect(described_class.all.where(lazy: true).where(lazy: true).where(lazy: true).selector)
      .to eq('lazy' => true)
  end

  it 'probably should duplicate selectors consistently' do
    # it replaces the $and again
    expect(described_class.all.where(lazy: true).where(lazy: true).where(lazy: false).selector)
      .to eq('lazy' => true, '$and' => [{ lazy: true }, { lazy: true }, { lazy: false }])
  end
end
