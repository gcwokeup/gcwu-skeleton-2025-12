# Bullet gem configuration
# Helps detect N+1 queries and unused eager loading

if defined?(Bullet)
  Bullet.enable = true
  Bullet.alert = false
  Bullet.bullet_logger = true
  Bullet.console = true
  Bullet.rails_logger = true
  Bullet.add_footer = true

  # Uncomment to raise errors instead of just warnings (strict mode)
  # Bullet.raise = true

  # Warn when using Counter Cache incorrectly
  Bullet.counter_cache_enable = true

  # Detect unused eager loading
  Bullet.unused_eager_loading_enable = true

  # Detect N+1 queries
  Bullet.n_plus_one_query_enable = true
end
