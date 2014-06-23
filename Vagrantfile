# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = 'phusion-open-ubuntu-14.04-amd64'
  config.vm.box_url = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box'

  config.vm.network :private_network, ip: '192.168.0.50'

  config.ssh.forward_agent = true

  config.vm.synced_folder '.', '/vagrant', type: 'nfs'

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '4096']
  end

  packages = [
    'vim-nox',
    'git-core',
    'tmux',
    'libterm-readkey-perl', # For git singlekey interactive
    'exuberant-ctags',
  ]
  repos = [
    'https://github.com/eremite/dotfiles',
    'https://github.com/eremite/dbload',
    'https://github.com/eremite/docker_rails_app',
    'https://github.com/eremite/done',
  ]
  config.vm.provision 'shell', inline: <<-HEREDOC
    sudo apt-get install -y #{packages.join(' ')}
    cd /tmp
    curl -s https://get.docker.io/ubuntu/ | sudo sh
    usermod -a -G docker vagrant
    wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb
    sudo dpkg -i rcm_1.2.3-1_all.deb
    cd /home/vagrant
    #{repos.map { |repo| "git clone #{repo}" }.join('; ')}
    ln -s dotfiles/rcrc .rcrc
    rcup -v
    cp /vagrant/.ssh/id* /home/vagrant/.ssh
    chown -R vagrant:vagrant /home/vagrant
  HEREDOC

end
