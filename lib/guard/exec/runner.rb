module Guard
  class Exec < Plugin
    class Runner
      DEFAULT_NAME = 'command'.freeze

      attr_accessor :options

      def initialize(options)
        @options = options
      end

      def run(paths = [])
        command = build_command(paths)
        show_command(command)
        system(command)
      end

      def title
        @title ||= "❱ #{name.capitalize}".colorize(options[:color])
      end

      private

      def name
        options[:name] || DEFAULT_NAME
      end

      def build_command(paths)
        command = [
          options[:command],
          options[:command_options],
          paths,
          options[:command_arguments]
        ]

        command.reject { |el| el.nil? || el.empty? }.join(' ')
      end

      def show_command(command)
        Compat::UI.info "\n#{title} [exec] : - #{command}\n\n"
      end
    end
  end
end
