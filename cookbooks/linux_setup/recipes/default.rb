#
# Cookbook Name:: linux_setup
# Recipe:: default
#
# Copyright 2011, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
user node[:linux][:user] do
  comment "System user"
  system true
  password "$1$fJtfEz8L$Lmz8Vp.2UraHZd9ZQ8CzD."
  not_if "cat /etc/passwd | grep #{node[:linux][:user]} >> /dev/null"
end

bash "change swappiness and file limits" do
  user "root"
  cwd "/etc"
  code <<-EOH
  echo "#{node[:linux][:user]}   soft    nofile  #{node[:linux][:filelimit]}" >> /etc/security/limits.conf
  echo "#{node[:linux][:user]}   hard    nofile  #{node[:linux][:filelimit]}" >> /etc/security/limits.conf
  echo "session    required   pam_limits.so" >> /etc/pam.d/su
  echo "vm.dirty_background_ratio = #{node[:linux][:dirty_background_ratio]}" >> /etc/sysctl.conf
  echo "vm.dirty_ratio = #{node[:linux][:dirty_ratio]}" >> /etc/sysctl.conf
  sysctl -e -p
  EOH
  not_if "sysctl -n vm.dirty_ratio | grep #{node[:linux][:dirty_ratio]} >> /dev/null"
end
