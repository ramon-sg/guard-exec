require "guard/compat/test/helper"

RSpec.describe Guard::Exec do
  let(:default_options) { Guard::Exec::Options::DEFAULTS }
  let(:options) do
    {
      name: 'minitest',
      command: 'crystal spec',
      command_options: '-d',
      command_arguments: '-- --chaos',
      color: :blue
    }
  end

  subject { described_class.new options }

  before { allow_any_instance_of(Guard::Exec::Runner).to receive(:run) }

  describe '.initialize' do
    context 'witput command option' do
      it 'raises MissingCommandOption' do
        expect { described_class.new }.to \
          raise_exception(Guard::Exec::MissingCommandOption)
      end
    end
  end

  describe '#run_all' do
    it 'shows message' do
      expect(Guard::Compat::UI).to receive(:info).with(%(Running all minitest))

      subject.run_all
    end

    it 'runs all' do
      expect(subject.runner).to receive(:run).with(no_args)

      subject.run_all
    end
  end

  describe '#run_on_modifications' do
    it 'show messages' do
      expect(Guard::Compat::UI).to \
        receive(:info).with(%(Running: [spec/router_spec.cr]), reset: true)

      subject.run_on_modifications(['spec/router_spec.cr'])
    end

    it 'runs command' do
      paths = [
        'spec/router_spec.cr',
        'spec/app_spec.cr'
      ]

      expect(subject.runner).to receive(:run).with(paths)

      subject.run_on_modifications(paths)
    end
  end
end
