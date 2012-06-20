namespace :rubber do
  namespace :base do
  
    rubber.allow_optional_tasks(self)

    # before "rubber:setup_gem_sources", "rubber:base:install_rvm"

    # ensure that the rvm profile script gets sourced by reconnecting
    # after "rubber:base:install_rvm" do
    #   teardown_connections_to(sessions.keys)
    # end

   # after "rubber:base:install_rvm", "rubber:base:install_rvm_ruby"

    after "rubber:install_packages", "rubber:base:configure_git" if scm == "git"
    task :configure_git do
      rubber.sudo_script 'configure_git', <<-ENDSCRIPT
        if [[ "#{repository}" =~ "@" ]]; then
          # Get host key for src machine to prevent ssh from failing
          rm -f ~/.ssh/known_hosts
          ssh -o 'StrictHostKeyChecking=no' #{repository.gsub(/:.*/, '')} &> /dev/null || true
        fi
      ENDSCRIPT
    end
    
    # We need a rails user for safer permissions used by deploy.rb
    after "rubber:install_packages", "rubber:base:custom_install"
    task :custom_install do
      rubber.sudo_script 'custom_install', <<-ENDSCRIPT
        # add the user for running app server with
        if ! id #{rubber_env.app_user} &> /dev/null; then adduser --system --group #{rubber_env.app_user}; fi
          
        # add ssh keys for root 
        if [[ ! -f /root/.ssh/id_dsa ]]; then ssh-keygen -q -t dsa -N '' -f /root/.ssh/id_dsa; fi
      ENDSCRIPT
    end

  end
end
