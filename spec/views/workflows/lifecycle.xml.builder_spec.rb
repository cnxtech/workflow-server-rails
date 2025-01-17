# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'workflows/lifecycle' do
  let(:druid) { 'druid:abc123' }
  let(:repo) { 'dor' }
  let(:params) { { druid: druid, repo: repo } }

  it 'renders a workflows document' do
    FactoryBot.create(
      :workflow_step,
      repository: repo,
      druid: druid,
      workflow: 'accessionWF'
    )
    @objects = WorkflowStep.all

    render template: 'workflows/lifecycle', locals: { params: params }
    doc = Nokogiri::XML.parse(rendered)
    expect(doc.at_xpath('//lifecycle')).to include %w[objectId druid:abc123]
    expect(doc.at_xpath('//milestone')).to include(
      ['version', /1/],
      ['date', //]
    )
  end
end
