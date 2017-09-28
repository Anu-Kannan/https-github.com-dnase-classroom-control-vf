class profile::base {
  $message = lookup('message')
  notify { $message: }
  # notify { "Hello, my name is ${::hostname}": }
}
