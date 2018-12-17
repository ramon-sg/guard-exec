module Guard
  class Exec < Plugin
    module Options
      DEFAULTS = {
        command: nil,
        command_options: nil,
        command_arguments: nil,
        name: nil,
        color: :light_green
      }.freeze

      class << self
        def with_defaults(options = {})
          _deep_merge(DEFAULTS, options)
        end

        private

        def _deep_merge(hash1, hash2)
          hash1.merge(hash2) do |_key, oldval, newval|
            if oldval.instance_of?(Hash) && newval.instance_of?(Hash)
              _deep_merge(oldval, newval)
            else
              newval
            end
          end
        end
      end
    end
  end
end
