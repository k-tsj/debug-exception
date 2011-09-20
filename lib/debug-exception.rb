require 'debug_exception'

at_exit {
  b = $!.instance_variable_get(:@binding)
  if b
    # from Irb#eval_input(lib/irb.rb)
    def error_print(exc)
      print exc.class, ": ", exc, "\n"
      messages = []
      lasts = []
      levels = 0
      back_trace_limit = 30
      for m in exc.backtrace
        if m
          if messages.size < back_trace_limit
            messages.push "\tfrom "+m
          else
            lasts.push "\tfrom "+m
            if lasts.size > back_trace_limit
              lasts.shift
              levels += 1
            end
          end
        end
      end
      print messages.join("\n"), "\n"
      unless lasts.empty?
        printf "... %d levels...\n", levels if levels > 0
        print lasts.join("\n")
      end
    end

    error_print($!)

    require 'irb'
    ::IRB::Irb.module_eval do
      alias_method :eval_input_orig, :eval_input
      define_method(:eval_input) do
        ::IRB::Irb.module_eval { alias_method :eval_input, :eval_input_orig }
        require 'irb/ext/multi-irb'
        ::IRB.irb(nil, b)
      end
    end
    IRB.start
    exit!
  end
}
