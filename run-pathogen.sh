#!/usr/bin/env bash
set -euo pipefail

usage() {
cat <<EOF
usage: $(basename $0) -i plugins_name -l

build images

arguments:
  -i <plugins_name>   plugins_name, e.g. 'pathogen'
  -l                  show installed plugins_list
  -t                  show supported plugins_list
  -a                  install all plugins
EOF
}

# Set VIM Plugins Global ENV
readonly kiki_pathogen_dir=${HOME}/.vim/autoload
readonly kiki_plugins_dir=${HOME}/.vim/bundle

readonly enable_pathogen=1

# 5+ windows plugins
readonly enable_winmanager=1
readonly enable_bufexplorer=1
readonly enable_taglist=1
readonly enable_tagbar=1
readonly enable_nerdtree_red=1

# 3+ status line plugins
readonly enable_lightline=1
readonly enable_airline=1
readonly enable_airline_themes=1

# 2+ color themes plugins
readonly enable_colors_solarized=1
readonly enable_colorschemes=1

# 2+ code edit plugins
readonly enable_youcompleteme=1
readonly enable_coc=1
readonly enable_global=1
readonly enable_ctrlp=1
readonly enable_drawit=1
readonly enable_demo=0

# list
readonly support_list=("pathogen" "winmanager" "bufexplorer"     "taglist" "tagbar" "nerdtree_red" "lightline"     "airline"     "airline_themes"     "colors_solarized"     "colorschemes" "youcompleteme" "coc"      "global"       "ctrlp"     "drawit")
readonly dir_list=("../autoload/" "winmanager" "minibufexpl.vim" "taglist" "tagbar" "nerdtree"     "lightline.vim" "vim-airline" "vim-airline-themes" "vim-colors-solarized" "colorschemes" "youcompleteme" "coc.nvim" "global-6.6.4" "ctrlp.vim" "DrawIt")

function show_installed_plugins() {
  if [ -d ${kiki_plugins_dir} ]; then
    echo "[-----show plugins-----]"
    for (( i=0; i<${#support_list[@]}; i++ ))
      do
      if [ -d ${kiki_plugins_dir}/${dir_list[$i]} ]; then
        echo -e "${support_list[$i]}\t\t: [OK]"
      else
        echo -e "${support_list[$i]}\t\t: [FAIL]"
      fi
    done
    echo "[-----show plugins-----]"
  else
    echo "non-installed plugins"
  fi
}

function show_supported_plugins() {
  echo "[-----supported plugins-----]"
  for (( i=0; i<${#support_list[@]}; i++ ))
  do
    echo ${support_list[$i]}
  done
  echo "[-----supported plugins-----]"
}

function install_all_plugins() {
  for (( i=0; i<${#support_list[@]}; i++ ))
  do
    # echo ${support_list[$i]}
    plugins_install ${support_list[$i]}
  done
}

function install_pathogen() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_pathogen} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installed.
  if [ -f ${kiki_pathogen_dir}/pathogen.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_pathogen_dir}"
    return 0
  fi

  # Install
  mkdir -p ${kiki_pathogen_dir} ${kiki_plugins_dir}
  echo "[${dbg_tag}]: installing at ${kiki_pathogen_dir}"
  curl -LSso ${kiki_pathogen_dir}/pathogen.vim https://tpo.pe/pathogen.vim

  if [ -f ${kiki_pathogen_dir}/pathogen.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_pathogen_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

# -----------------------------
#   VIM window plugins
# -----------------------------
function install_winmanager() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_winmanager} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
	  return 0
  fi

  # check it is or not installed
  if [ -f ${kiki_plugins_dir}/winmanager/plugin/winmanager.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/vim-scripts/winmanager ${kiki_plugins_dir}/winmanager

  if [ -f ${kiki_plugins_dir}/winmanager/plugin/winmanager.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_bufexplorer() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_bufexplorer} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installed
  if [ -f ${kiki_plugins_dir}/minibufexpl.vim/plugin/minibufexpl.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/fholgado/minibufexpl.vim ${kiki_plugins_dir}/minibufexpl.vim

  if [ -f ${kiki_plugins_dir}/minibufexpl.vim/plugin/minibufexpl.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_taglist() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_taglist} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installe
  if [ -f ${kiki_plugins_dir}/taglist/plugin/taglist.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone http://github.com/yegappan/taglist ${kiki_plugins_dir}/taglist

  if [ -f ${kiki_plugins_dir}/taglist/plugin/taglist.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_tagbar() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_tagbar} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installe
  if [ -f ${kiki_plugins_dir}/tagbar/plugin/tagbar.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/preservim/tagbar ${kiki_plugins_dir}/tagbar

  if [ -f ${kiki_plugins_dir}/tagbar/plugin/tagbar.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_nerdtree_red() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_nerdtree_red} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installe
  if [ -f ${kiki_plugins_dir}/nerdtree/plugin/NERD_tree.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/scrooloose/nerdtree ${kiki_plugins_dir}/nerdtree

  if [ -f ${kiki_plugins_dir}/nerdtree/plugin/NERD_tree.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

# -----------------------------
#   VIM status line plugins
# -----------------------------
function install_lightline() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_lightline} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  # check it is or not installe
  if [ -f ${kiki_plugins_dir}/lightline.vim/plugin/lightline.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/itchyny/lightline.vim  ${kiki_plugins_dir}/lightline.vim

  if [ -f ${kiki_plugins_dir}/lightline.vim/plugin/lightline.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_airline() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_airline} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/vim-airline/plugin/airline.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/vim-airline/vim-airline ${kiki_plugins_dir}/vim-airline
  
  if [ -f ${kiki_plugins_dir}/vim-airline/plugin/airline.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_airline_themes() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_airline_themes} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/vim-airline-themes/plugin/airline-themes.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/vim-airline/vim-airline-themes ${kiki_plugins_dir}/vim-airline-themes

  if [ -f ${kiki_plugins_dir}/vim-airline-themes/plugin/airline-themes.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

# -----------------------------
#   VIM color themes plugins
# -----------------------------
function install_colors_solarized() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_colors_solarized} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/vim-colors-solarized/colors/solarized.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/altercation/vim-colors-solarized ${kiki_plugins_dir}/vim-colors-solarized

  if [ -f ${kiki_plugins_dir}/vim-colors-solarized/colors/solarized.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}" 
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_colorschemes() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_colorschemes} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/colorschemes/README.md ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/flazz/vim-colorschemes.git ${kiki_plugins_dir}/colorschemes

  if [ -f ${kiki_plugins_dir}/colorschemes/README.md ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

# -----------------------------
#   VIM code plugins
# -----------------------------
function install_youcompleteme() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_youcompleteme} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/youcompleteme/plugin/youcompleteme.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    if [ -f ${kiki_plugins_dir}/youcompleteme/cpp/ycm/.ycm_extra_conf.py ]; then
      echo "[${dbg_tag}]: ycm setting done"
      return 0
    else
      echo "[${dbg_tag}]: ycm need setup again"
      rm -rf ${kiki_plugins_dir}/youcompleteme
    fi
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/valloric/youcompleteme ${kiki_plugins_dir}/youcompleteme
  pushd ${kiki_plugins_dir}/youcompleteme
    git submodule update --init --recursive
    echo "[${dbg_tag}]: add support"
    ./install.sh --clang-completer --system-libclang
  popd

  # youcompleteme/cpp/ycm/.ycm_extra_conf.py
  # fix ycm load error
  if [ -f ${kiki_plugins_dir}/youcompleteme/cpp/ycm/.ycm_extra_conf.py ]; then
    echo ""
  else
    echo "[${dbg_tag}]: create the example"
    mkdir -p ${kiki_plugins_dir}/youcompleteme/cpp/ycm
    cp ${kiki_plugins_dir}/youcompleteme/third_party/ycmd/examples/.ycm_extra_conf.py ${kiki_plugins_dir}/youcompleteme/cpp/ycm
  fi

  if [ -f ${kiki_plugins_dir}/youcompleteme/plugin/youcompleteme.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_global() {
  dbg_tag="${FUNCNAME/install_/}"
  if [ ${enable_global} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${kiki_plugins_dir}/global-6.6.4/plugin/gtags-cscope.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  wget http://tamacom.com/global/global-6.6.4.tar.gz -P ${kiki_plugins_dir}
  tar xzf ${kiki_plugins_dir}/global-6.6.4.tar.gz -C ${kiki_plugins_dir}
  rm ${kiki_plugins_dir}/global-6.6.4.tar.gz
  pushd ${kiki_plugins_dir}/global-6.6.4
    chmod 777 ./configure
    ./configure > /dev/null
    make -j8 > /dev/null

    # Create 'plugin' dir for pathogen
    mkdir -p ${kiki_plugins_dir}/global-6.6.4/plugin
    cp ${kiki_plugins_dir}/global-6.6.4/gtags.vim ${kiki_plugins_dir}/global-6.6.4/plugin
    cp ${kiki_plugins_dir}/global-6.6.4/gtags-cscope.vim ${kiki_plugins_dir}/global-6.6.4/plugin

    # Add global tool path into $PATH ENV

    if [ -f /home/${USER}/.bashrc ]; then
      echo ".bashrc is exist"
    else
      touch /home/${USER}/.bashrc
    fi

    echo "[${dbg_tag}]: Add global env into .bashrc"
    echo "export PATH=\${PATH}:${kiki_plugins_dir}/global-6.6.4/global"      >> /home/${USER}/.bashrc
    echo "export PATH=\${PATH}:${kiki_plugins_dir}/global-6.6.4/gtags-cscope">> /home/${USER}/.bashrc
    echo "export PATH=\${PATH}:${kiki_plugins_dir}/global-6.6.4/gtags"       >> /home/${USER}/.bashrc
    echo "export PATH=\${PATH}:${kiki_plugins_dir}/global-6.6.4/htags"       >> /home/${USER}/.bashrc

    # 
  popd

  if [ -f ${kiki_plugins_dir}/global-6.6.4/plugin/gtags-cscope.vim ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_ctrlp() {
  dbg_tag="${FUNCNAME/install_/}"
  file_check="${kiki_plugins_dir}/ctrlp.vim/plugin/ctrlp.vim"
  if [ ${enable_ctrlp} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/kien/ctrlp.vim ${kiki_plugins_dir}/ctrlp.vim

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_coc_nvim() {
  dbg_tag="${FUNCNAME/install_/}"
  file_check="${kiki_plugins_dir}/coc.nvim/autoload/coc.vim"
  if [ ${enable_coc} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  echo "NodeJs need > v16.17"
  echo "you can add \"alias nodejs='/usr/local/bin/node'\" into your .bashrc"

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    if ! [ -f ${kiki_plugins_dir}/coc.nvim/build/index.js ]; then
      # Build
      echo "build/index.js not found, try to call yarn"
      alias nodejs='/usr/local/bin/node'
      pushd ${kiki_plugins_dir}/coc.nvim/
      yarn install
      yarn build
      pushd
    fi
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/neoclide/coc.nvim ${kiki_plugins_dir}/coc.nvim

  # Build
  alias nodejs='/usr/local/bin/node'
  pushd ${kiki_plugins_dir}/coc.nvim/
  yarn install
  yarn build
  pushd


  if [ -f /home/${USER}/.bashrc ]; then
    echo ".bashrc is exist"
  else
    touch /home/${USER}/.bashrc
  fi

  echo "[${dbg_tag}]: Add global env into .bashrc"
  echo "export PATH=\${PATH}:${HOME}/.config/coc/extensions/coc-clangd-data/install/14.0.3/clangd_14.0.3/bin"       >> /home/${USER}/.bashrc

  # $ vim 1.cc
  # Add C++ support
  # : CocInstall coc-clangd
  # : CocCommand clangd.install
  #
  # Add multi supports
  # : CocInstall coc-sh coc-git coc-json coc-vimlsp coc-pairs
  # Add extra support
  # : CocInstall coc-json coc-tsserver

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_drawit() {
  dbg_tag="${FUNCNAME/install_/}"
  file_check="${kiki_plugins_dir}/DrawIt/plugin/DrawItPlugin.vim"
  if [ ${enable_drawit} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  git clone https://github.com/vim-scripts/DrawIt.git ${kiki_plugins_dir}/DrawIt

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}

function install_demo() {
  dbg_tag="${FUNCNAME/install_/}"
  file_check="${kiki_plugins_dir}/nerdcommenter/plugin/nerdcommenter.vim"
  if [ ${enable_demo} = "0" ]; then
    echo "[${dbg_tag}]: disabled"
    return 0
  fi

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  # Install
  echo "[${dbg_tag}]: installing at ${kiki_plugins_dir}"
  # please add the 
  # 

  if [ -f ${file_check} ]; then
    echo "[${dbg_tag}]: installed at ${kiki_plugins_dir}"
    return 0
  fi

  echo "[${dbg_tag}]: install failed"
  exit 1
}
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------


# Install Plugins
function plugins_install() {
  if [ $# -ne 1 ]; then
    echo "Usage: install_plugins <plugins_name>"
    exit 1
  fi

  new_plugins=$1
  case ${new_plugins} in
    # <pathogen> - VIM Plugins manager tools
    pathogen)
      install_pathogen
      ;;
    # ----------------------------------------------
    #           VIM window plugins: 5+
    # ----------------------------------------------
    # <winmanager> - VIM window plugins manager tool
    #
    # --- <bufexplorer>   - 
    # --- <taglist>       - show file taglist
    # --- <tagbar>        - show file taglist
    # --- <nerdtree-red>  - file tree
    #
    winmanager)
      install_winmanager
      ;;
    bufexplorer)
      install_bufexplorer
      ;;
    taglist)
      install_taglist
      ;;
    tagbar)
      install_tagbar
      ;;
    nerdtree_red)
      install_nerdtree_red
      ;;
    # ----------------------------------------------
    #           VIM status line plugins: 3+
    # ----------------------------------------------
    # --- <lightline>     - show line status
    # --- <airline>       - show line status
    # ----<airline-themes>- status line themes
    lightline)
      install_lightline
      ;;
    airline)
      install_airline
      ;;
    airline_themes)
      install_airline_themes
      ;;
    # ----------------------------------------------
    #           VIM color themes plugins: 2+
    # ----------------------------------------------
    # --- <colors-solarized> - provide "solarized' themes
    # --- <colorschemes>     - support multi themes
    colors_solarized)
      install_colors_solarized
      ;;
    colorschemes)
      install_colorschemes
      ;;
    # ----------------------------------------------
    #           VIM code plugins: 2+
    # ----------------------------------------------
    # --- <youcompleteme> - Code auto-hinting
    # --- <global>        - Code search (like 'Source Insight')
    youcompleteme)
      install_youcompleteme
      ;;
    coc)
      install_coc_nvim
      ;;
    global)
      install_global
      ;;
    ctrlp)
      install_ctrlp
      ;;
    drawit)
      install_drawit
      ;;
    # 
    # ----------------------------------------------
    #           VIM other plugins
    # ----------------------------------------------
    #) 
    #  ;;

    # ----------------------------------------------
    #           VIM plugins end
    # ----------------------------------------------
    *)
      echo "Unsupport plugins - ${new_plugins}"
      exit 1
      ;;
  esac

  return 0
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

while getopts ":i:ahlt" opt; do
  case $opt in
    i)
      plugins_name=$OPTARG
      plugins_install ${plugins_name}
      if [ "${plugins_name}" == "global" ]; then
        echo -e "\n\n\n\n"
        echo "Please add this command into $HOME/.vimrc, let vim run the plugins"
        echo -e "\ncommand: "
        echo "  source $HOME/.vim/run-pathogen.vim"
        echo -e "\n"
        echo "After that, please reconnect the session"
        echo ""
        echo -e "\n\n\n\n"
      fi
      ;;
    a)
      install_all_plugins
      echo -e "\n\n\n\n"
      echo "Please add this command into $HOME/.vimrc, let vim run the plugins"
      echo -e "\ncommand: "
      echo "  source $HOME/.vim/run-pathogen.vim"
      echo -e "\n"
      echo "After that, please reconnect the session"
      echo ""
      echo -e "\n\n\n\n"
      ;;
    t)
      show_supported_plugins
      ;;
    l)
      show_installed_plugins
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
  esac
done


