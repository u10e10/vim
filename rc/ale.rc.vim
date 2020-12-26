" Disable features
let g:ale_history_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 0
let g:ale_fix_on_save = 0

let g:ale_set_signs = 1
let g:ale_virtualtext_cursor = 1
let g:ale_set_highlights = 0
let g:ale_echo_cursor = 0

" Lint config
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_save = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_delay = 1000

" Sign
let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = '🛈'

" Virtualtext
let g:ale_virtualtext_prefix = ' ← '
" let g:ale_virtualtext_delay = 10

" List
let g:ale_set_quickfix = 1
let g:ale_set_loclist = !g:ale_set_quickfix
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_list_window_size = 5
let g:ale_list_window_open_type= 'botright'


" Buffer only samples
" let b:ale_ruby_rubocop_executable = 'bundle exec rubocop'
" let b:ale_ruby_rubocop_executable = 'docker-compose exec api bundle exec rubocop'
" let b:ale_typescriptreact_eslint_executable = 'docker-compose exec ui yarn lint'

let g:ale_linter_aliases = {
  \ 'jsx': ['javascriptreact'],
  \ 'javascriptreact': ['javascript'],
  \ 'typescriptreact': ['typescript'],
  \ }

let g:ale_linters = {
  \ 'c': ['clang'],
  \ 'javascript': ['eslint'],
  \ 'jsx': ['eslint'],
  \ 'markdown': [],
  \ 'python': ['flake8'],
  \ 'ruby': ['rubocop'],
  \ 'rust': ['rustc', 'rustfmt'],
  \ 'typescript': ['eslint'],
  \ }

let g:ale_fixers = {
  \ 'c': ['clang-format'],
  \ 'cpp': ['clang-format'],
  \ 'go': ['gofmt'],
  \ 'javascript': ['eslint'],
  \ 'python': ['autopep8'],
  \ 'ruby': ['rubocop'],
  \ 'typescript': ['eslint'],
  \ 'vim': ['vint'],
  \ }

let g:ale_pattern_options = {
  \ '\.min\.js$': { 'ale_enabled': 0 },
  \ '\.toml$': { 'ale_enabled': 0 },
  \ '\.gql$': { 'ale_enabled': 0 },
  \ '\.gem/ruby/': { 'ale_enabled': 0 },
  \ 'src/gems/': { 'ale_enabled': 0 },
  \ 'src/npm/': { 'ale_enabled': 0 },
  \ }


" General text lint
let g:ale_warn_about_trailing_whitespace = 1
let g:ale_warn_about_trailing_blank_lines = 1

" Ruby
" let g:ale_ruby_rubocop_auto_correct_all = 1
