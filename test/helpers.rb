# A string describing the path to the "test" directory.
ROOT = File.dirname __FILE__

# Capture STDOUT and STDERR
def capture &block
  original_stdout = $stdout
  original_stderr = $stderr

  $stdout = fake_stdout = StringIO.new
  $stderr = fake_stderr = StringIO.new

  begin
    yield
  ensure
    $stdout = original_stdout
    $stderr = original_stderr
  end

  [fake_stdout.string, fake_stderr.string]
end
