fx_version 'cerulean'
game { 'gta5' }
author 'j-script'
description '[Standalone]'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/style.css',
    'html/script.js'
}

shared_scripts{
    '@ox_lib/init.lua',
}

client_scripts {
    'client/main.lua'

}

server_scripts {
    'server/main.lua'

}