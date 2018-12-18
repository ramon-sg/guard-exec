RSpec.describe Guard::Exec::Runner do
  before { allow($stdout).to receive(:puts) }

  let(:options) do
    Guard::Exec::Options.with_defaults(
      name: 'listing',
      command: 'ls',
      command_options: '-a',
      command_arguments: '| grep ruby',
      color: :blue
    )
  end

  let(:default_options) { Guard::Exec::Options::DEFAULTS }

  subject { described_class.new(options) }

  describe '#title' do
    it 'returns title' do
      expect(subject.title).to eq(%(\e[0;34;49m❱ Listing\e[0m))
    end

    context 'with default' do
      subject { described_class.new(default_options) }

      it { expect(subject.title).to eq(%(\e[0;92;49m❱ Command\e[0m)) }
    end
  end

  describe '#run' do
    it 'runs command' do
      expect(subject).to receive(:system).with('ls -a | grep ruby')
      expect($stdout).to \
        receive(:puts).with(%(\n\e[0;34;49m❱ Listing\e[0m [exec] : - ls -a | grep ruby\n\n))

      subject.run
    end

    context 'with paths' do
      it 'runs command' do
        expect(subject).to receive(:system).with('ls -a / | grep ruby')
        expect($stdout).to \
          receive(:puts).with(%(\n\e[0;34;49m❱ Listing\e[0m [exec] : - ls -a / | grep ruby\n\n))

        subject.run ['/']
      end
    end

    context 'without command_options' do
      before { subject.options[:command_options] = nil }

      it 'runs command' do
        expect(subject).to receive(:system).with('ls / | grep ruby')
        expect($stdout).to \
          receive(:puts).with(%(\n\e[0;34;49m❱ Listing\e[0m [exec] : - ls / | grep ruby\n\n))

        subject.run ['/']
      end

      context 'without command_arguments' do
        before { subject.options[:command_arguments] = nil }

        it 'runs command' do
          expect(subject).to receive(:system).with('ls /')
          expect($stdout).to \
            receive(:puts).with(%(\n\e[0;34;49m❱ Listing\e[0m [exec] : - ls /\n\n))

          subject.run ['/']
        end
      end
    end
  end
end
