RSpec.describe Guard::Exec::Options do
  describe '.with_defaults' do
    context 'with empty hash' do
      subject { described_class.with_defaults({}) }

      it { expect(subject[:command]).to be_nil }
      it { expect(subject[:command_options]).to be_nil }
      it { expect(subject[:command_arguments]).to be_nil }
      it { expect(subject[:name]).to be_nil }
      it { expect(subject[:color]).to eq :light_green }
    end

    context 'with hash' do
      subject do
        described_class.with_defaults(
          command: 'crystal spec',
          command_options: '-d',
          command_arguments: '-- --chaos',
          name: 'Minitest',
          color: :green
        )
      end

      it { expect(subject[:command]).to eq 'crystal spec' }
      it { expect(subject[:command_options]).to eq '-d' }
      it { expect(subject[:command_arguments]).to eq '-- --chaos' }
      it { expect(subject[:name]).to eq 'Minitest' }
      it { expect(subject[:color]).to eq :green }
    end
  end
end
