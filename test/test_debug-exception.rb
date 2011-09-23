require 'test/unit'
require 'pty'
require 'timeout'

class DebugExceptionTest < Test::Unit::TestCase
  RUBY = RbConfig.ruby
  LIB = File.expand_path("../../lib", __FILE__)

  def test_start_repl_on_exception
    timeout(2) {
      begin
        r, w, pid = PTY.spawn(RUBY, '-I', LIB, '-rdebug-exception',
                        '-e', 'def f(i); raise "test"; end; f(999)')
        assert_match(/RuntimeError/, r.gets)
        assert_match(/from -e/, r.gets)
        assert_match(/from -e/, r.gets)
        assert_match(/irb/, r.readpartial(20))
        w.puts 'i'
        assert_match(/999/, r.readpartial(20))
        w.puts 'exit'
      ensure
        if pid
          _, stat = Process.wait2(pid)
          assert_equal(true, stat.exited?)
        end
      end
    }
  end

  def test_avoid_systemstackerror
    timeout(2) {
      begin
        r, w, pid = PTY.spawn(RUBY, '-I', LIB, '-rdebug-exception',
                        '-e', 'Thread.new("$_", &Object.method(:eval)).join')
        assert_match(/RuntimeError/, r.gets)
      ensure
        if pid
          _, stat = Process.wait2(pid)
          assert_equal(true, stat.exited?)
        end
      end
    }
  end
end
