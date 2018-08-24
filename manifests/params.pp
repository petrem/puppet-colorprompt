class colorprompt::params {
  $ensure            = present
  $path              = '/etc/profile.d/colorprompt.sh'
  $default_usercolor = undef
  $custom_usercolors = { 'root' => 'red' }
  $host_color        = undef
  $env_name          = undef
  $env_color         = undef

  case $::osfamily {
    'RedHat': {
      $prompt      = '${env}[${userColor}\u\[\e[0m\]@${hostColor}\h\[\e[0m\] \W]\\\\$ '
      $modify_skel = false
      $modify_root = false
    }

    'Debian': {
      $prompt      = '${env}${debian_chroot:+($debian_chroot)}${userColor}\u\[\e[0m\]@${hostColor}\h\[\e[0m\]:\w\\\\$ '
      $modify_skel = true
      $modify_root = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  }
}
