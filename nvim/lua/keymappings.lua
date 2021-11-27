local utils = require('utils')

utils.map('n', '<C-l>', '<cmd>noh<CR>')                                 -- Clear highlights
utils.map('i', 'jk', '<Esc>')                                           -- jk to escape
utils.map('n', '<Leader>ad', '<cmd>Explore<CR>')                        -- FileExplorere
utils.map('t', '<Esc>', '<C-\\><C-n>')                        -- FileExplorere
