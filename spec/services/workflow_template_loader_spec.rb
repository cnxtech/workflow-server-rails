# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WorkflowTemplateLoader do
  let(:loader) { described_class.new(workflow_name, repository) }

  let(:workflow_name) { 'assemblyWF' }

  let(:repository) { nil }

  describe '#workflow_filepath' do
    let(:workflow_filepath) { loader.workflow_filepath }

    context 'when workflow and repo provided' do
      let(:repository) { 'dor' }
      it 'finds filepath' do
        expect(workflow_filepath).to eq("config/workflows/#{repository}/#{workflow_name}.xml")
      end
    end

    context 'when only workflow provided' do
      it 'finds filepath' do
        expect(workflow_filepath).to eq("config/workflows/dor/#{workflow_name}.xml")
      end
    end
  end

  describe '#exists?' do
    context 'when file exists' do
      it 'returns true' do
        expect(loader.exists?).to eq true
      end
    end
    context 'when file does not exist' do
      let(:workflow_name) { 'xassemblyWF' }
      it 'returns false' do
        expect(loader.exists?).to eq false
      end
    end
  end

  describe '#load' do
    context 'when file exists' do
      it 'returns file as string' do
        expect(loader.load).to start_with('<?xml')
      end
    end
    context 'when file does not exist' do
      let(:workflow_name) { 'xassemblyWF' }
      it 'returns nil' do
        expect(loader.load).to be_nil
      end
    end
  end

  describe '#load_as_xml' do
    context 'when file exists' do
      it 'returns file as XML' do
        expect(loader.load_as_xml).to be_a(Nokogiri::XML::Document)
      end
    end
    context 'when file does not exist' do
      let(:workflow_name) { 'xassemblyWF' }
      it 'returns nil' do
        expect(loader.load_as_xml).to be_nil
      end
    end
  end
end
