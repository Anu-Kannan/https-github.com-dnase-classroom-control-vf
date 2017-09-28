class profile::base {
# This is where you can declare classes for all nodes.
# Example:
# class { 'my_class': }
$message = lookup('message')
$address = lookup('adress')
$phone = lookup('phone')

notify { $message: }
notify { $address: }
notify { $phone: }
}
