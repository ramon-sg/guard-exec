# Guard::Exec
![gem_version](https://img.shields.io/badge/gem__version-0.1.0-green.svg)

## Install

Add the gem to your Gemfile (inside development group):

``` ruby
 gem 'guard-exec', require: false
```

Add guard definition to your Guardfile by running this command:

```
$ bundle exec guard init rspec
```

## Usage

Please read [Guard usage doc](https://github.com/guard/guard#readme).

## Guardfile

Guard::Exec can be adapted to all kinds of projects.

### Options

```
# [command] [command_options] paths [commands_arguments]
# for crystal minitest:
$ crystal spec -d spec/router.cr -- --chaos
```

The following options are available:

- name
  The display name of your process in Guard, this is shown when Guard::Exec is starting
- color
  The display color of yout proccess, Please read
  [Colorize usage](https://github.com/fazibear/colorize).
- command
  The command to run as you would run it from the command line `crystal spec`
- command_options
  The command options or switches ` -d`
- commands_arguments
  The command arguments ` -- --chaos`

## Examples

### Crystal minitest

``` ruby
# crystal spec -- --chaos
guard :exec, name: 'Minitest', command: 'crystal spec', comand_arguments: '-- --chaos' do
  watch(%r{^spec/(.*)_spec\.cr})
  watch(%r{^src/(.+)\.cr$}) { |m| "spec/#{m[1]}_spec.cr" }
end

```

### Elixir Test
``` ruby
# mix test
guard :exec, name: 'Test', command: 'mix test' do
  watch(%r{^test/(.*)_test\.exs})
  watch(%r{^lib/(.+)\.ex$})         { |m| "test/#{m[1]}_test.exs" }
  watch(%r{^test/test_helper.exs$}) { "test" }
end
```

### Elixir Credo
``` ruby
# mix credo --strict --format=oneline
credo = {
  name: 'Credo',
  command: 'mix credo',
  command_options: '--strict --format=oneline',
  color: :yellow
}

guard :exec, credo do
  watch(%r{\.(erl|ex|exs|eex|xrl|yrl)$})
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/clouw/guard-exec.
