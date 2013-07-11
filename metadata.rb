name              "git"
maintainer        "Ingo Pfennigstorf"
maintainer_email  "i.pfennigstorf@gmail.com"
license           "MIT"
description       "Installs oai harvester"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "1.0.0"
recipe            "oai", "Installs oai harvester"

%w{ arch centos debian fedora redhat scientific oracle amazon ubuntu }.each do |os|
  supports os
end