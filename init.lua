require("plugins").setup()

vim.cmd "au VimEnter,VimResume * set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.cmd "au VimLeave,VimSuspend * set guicursor=a:ver20-blinkwait700-blinkoff400-blinkon250"
