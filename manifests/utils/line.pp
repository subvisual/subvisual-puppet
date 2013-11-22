# ensure a line exists in a file
define gb::utils::line($file, $line, $ensure = 'present') {
  case $ensure {
    default : { err ( "unknown value ${ensure}" ) }
    present: {
      exec { "/bin/echo '${line}' >> ${file}":
        unless => "/bin/grep -qFx '${line}' '${file}",
      }
    }
    absent: {
      exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E$/' ${file}":
        onlyif => "/bin/grep -qFX '${line}' ${file}",
      }
    }
  }
}
