rubber-template
===============

Ubuntu 12.04, rails 3.2.x, ruby 1.9.x (from packages - no rvm), ...

I have no idea what I'm doing yet..  But the example templates were either
broken or used backward methods (rvm instead of just using 1.9.x from ubuntu
packages).

Started with ``minimal_mysql``

 * Fixed mysql permissions issue on Ubuntu 12.04 - see comment in 
   deploy-mysql.rb
 * Removed RVM and used ubuntu's 1.9.x packages
 * put ssh key into repo (probably really bad...)
 * remove ec2-ami-tools since it pulls in ruby 1.8 - this probably
   breaks bundling.
 * removed mongrel + haproxy in favor of nginx + unicorn

Issues:

 * attempting to get asset pipeline to work (currently you have to manually
   precompile the assets by ssh-ing in
 * ``rake1.9.1`` exists but ``rake`` doesn't exist
 * only tested using ``rubber:create_staging`` - haven't created individual
   roles yet
