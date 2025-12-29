# BetterErrors configuration
# Provides better error pages with REPL in development

if defined?(BetterErrors)
  # Allow access from Docker, VMs, or remote development environments
  # Uncomment and adjust as needed:
  # BetterErrors::Middleware.allow_ip! '10.0.0.0/8'
  # BetterErrors::Middleware.allow_ip! '172.16.0.0/12'
  # BetterErrors::Middleware.allow_ip! '192.168.0.0/16'

  # Open files in your editor when clicking on stack traces
  # Uncomment and adjust for your IDE:

  # For RubyMine
  # BetterErrors.editor = "x-mine://open?file=%{file}&line=%{line}"

  # For VS Code / Cursor
  # BetterErrors.editor = "vscode://file/%{file}:%{line}"

  # For Sublime Text
  # BetterErrors.editor = "subl://open?url=file://%{file}&line=%{line}"

  # For TextMate
  # BetterErrors.editor = "txmt://open?url=file://%{file}&line=%{line}"
end
