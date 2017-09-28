class profile::base {
# This is where you can declare classes for all nodes.
# Example:
# class { 'my_class': }
$message = lookup('message')
$address = lookup('address')
$phone = lookup('phone')
$company = lookup('company')
notify { $message: }
notify { $address: }
notify { $phone: }
notify { $company: }
}
