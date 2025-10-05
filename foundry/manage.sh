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

    scp -F ssh-config -r vagrant@default:foundrydata/Backups/ backup/
    scp -F ssh-config -r vagrant@default:foundrydata/Data/assets/ backup/Data
    scp -F ssh-config -r vagrant@default:foundrydata/Data/ddb-images backup/Data
    scp -F ssh-config -r vagrant@default:foundrydata/Data/tokenizer backup/Data

    manage_foundry start
    rm ssh-config
}

restore_data () {
    get_ssh_config
    manage_foundry stop

    scp -F ssh-config -r backup/Backups/ vagrant@default:foundrydata/
    scp -F ssh-config -r backup/Data/assets/ vagrant@default:foundrydata/Data
    scp -F ssh-config -r backup/Data/ddb-images vagrant@default:foundrydata/Data
    scp -F ssh-config -r backup/Data/tokenizer vagrant@default:foundrydata/Data

    manage_foundry start
    rm ssh-config
}
