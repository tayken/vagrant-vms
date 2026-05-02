#! /bin/bash

get_ssh_config () {
    vagrant ssh-config > ssh-config
}

manage_foundry () {
    ssh -F ssh-config vagrant@default pm2 ${1} foundry
}

backup_data () {
    get_ssh_config
    mkdir -p backup/Data
    manage_foundry stop

    rsync -e "ssh -F ssh-config" -azv --delete vagrant@default:foundrydata/Backups backup/
    rsync -e "ssh -F ssh-config" -azv --delete vagrant@default:foundrydata/Data/assets backup/Data
    rsync -e "ssh -F ssh-config" -azv --delete vagrant@default:foundrydata/Data/ddb-images backup/Data
    rsync -e "ssh -F ssh-config" -azv --delete vagrant@default:foundrydata/Data/tokenizer backup/Data

    manage_foundry start
    rm ssh-config
}

restore_data () {
    get_ssh_config
    manage_foundry stop

    rsync -e "ssh -F ssh-config" -azv --delete backup/Backups vagrant@default:foundrydata
    rsync -e "ssh -F ssh-config" -azv --delete backup/Data/assets vagrant@default:foundrydata/Data
    rsync -e "ssh -F ssh-config" -azv --delete backup/Data/ddb-images vagrant@default:foundrydata/Data
    rsync -e "ssh -F ssh-config" -azv --delete backup/Data/tokenizer vagrant@default:foundrydata/Data

    manage_foundry start
    rm ssh-config
}
